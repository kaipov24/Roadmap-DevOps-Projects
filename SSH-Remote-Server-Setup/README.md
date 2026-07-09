# Linux Server SSH Setup

In this project, I created a remote Linux server using a DigitalOcean Droplet and configured SSH access.

I created two separate SSH key pairs and added both public keys during the Droplet setup.

![SSH keys](./images/screenshot-8.png)

The first key was created at:

```bash
/home/kairat/.ssh/id_ed25519
```

![SSH first key](./images/screenshot-1.png)

The second key was created in another folder:

```bash
/home/kairat/public-ssh/.ssh/id_ed25519
```

![SSH second key](./images/screenshot-2.png)

After the server was created, I tested the connection with both private keys.

![SSH connection using the first key](./images/screenshot-3.png)

![Created test folder](./images/screenshot-4.png)

![SSH connection using the second key](./images/screenshot-5.png)

![Check the test folder](./images/screenshot-6.png)

Both SSH keys worked successfully.

![Droplet](./images/screenshot-7.png)