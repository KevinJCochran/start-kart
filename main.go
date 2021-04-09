package main

import (
	"os"
	"log"
	"context"
	"github.com/digitalocean/godo"
	"github.com/joho/godotenv"
)

func main() {
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}

	token := os.Getenv("DO_TOKEN")

	client := godo.NewFromToken(token)
	ctx := context.TODO()

	newDroplet := createDroplet(client, ctx)

	log.Printf("New droplet: %v", newDroplet)
}

func createDroplet(client *godo.Client, ctx context.Context) *godo.Droplet {
	sshFingerprint := os.Getenv("DO_SSH_FINGERPRINT")

	workKey := godo.DropletCreateSSHKey{Fingerprint: sshFingerprint}
	createRequest := &godo.DropletCreateRequest{
		Name:   "srb2kart-server",
		Region: "nyc3",
		Size:   "s-1vcpu-1gb",
		Image: godo.DropletCreateImage{
			Slug: "ubuntu-20-04-x64",
		},
		SSHKeys: []godo.DropletCreateSSHKey{workKey},
		IPv6: false,
		Tags: []string{"srb2kart"},
	}

	droplet, _, err := client.Droplets.Create(ctx, createRequest)
	if err != nil {
		log.Printf("Unable to create droplet: %v", err.Error())
	}

	return droplet
}
