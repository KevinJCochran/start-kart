package main

import (
	"context"
	"fmt"
	"github.com/digitalocean/godo"
)

var sshFingerprint = ""
var token = ""

func main() {
	client := godo.NewFromToken(token)
	ctx := context.TODO()

	newDroplet := createDroplet(client, ctx)

	fmt.Printf("New droplet: %v", newDroplet)
}

func createDroplet(client *godo.Client, ctx context.Context) *godo.Droplet {
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
		fmt.Printf("Unable to create droplet: %v", err.Error())
	}

	return droplet
}
