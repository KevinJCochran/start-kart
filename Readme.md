# start-kart
Scripts for setting up [SRB2Kart](https://wiki.srb2.org/wiki/SRB2Kart) on a DigitalOcean dropplet.

There are two main scripts for this, `main.go` which uses the DigitalOcean API to create droplets and `setup.sh` which installs SRB2Kart and mods onto the freshly generated droplet.
`setup.sh` can theoretically be used alone, but it makes many assumptions about the environment in which it is executed, so you might have to adapt it to your needs.

### Setup
Some secrets are required for interacting with DigitalOcean programatically.
You can set these up in a `.env` file.
- `DO_TOKEN`: Generated personal access token for your DigitalOcean account.  Can be generated and found [here](https://cloud.digitalocean.com/account/api/tokens).
- `DO_SSH_FINGERPRINT`: This tells DigitalOcean which SSH keys you'll be using.  You can find your ssh fingerprints [here](https://cloud.digitalocean.com/account/security).  They sort of look like IPv6 addresses.

### Creating your droplet
To create the droplet, simply run `go run main.go`.

### Setting up your droplet
Unfortunately, the next step requires us to go to DigitalOcean's website to find the droplet you've just created.  Once it is finished initializing, take note of its IP Address.

With the IP Address, you can run the setup script on the instance with `ssh root@<IP_ADDRESS> < setup.sh`.
This will finish the setup process and the server should be ready for play momentarily.


### Future Work
Ideally, both steps would be able to be executed at once.

If that isn't possible, it would be nice to get the instance information via a command so as to not need to visit DigitalOcean's website to get the IP Address needed.
