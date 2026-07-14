# Dummy Systemd Service

I created a custom systemd service file at:

```bash
/etc/systemd/system/dummy.service
```

The service runs this script:

```bash
/home/kairat/Desktop/dummy.sh
```

The script writes logs to:

```bash
/var/log/dummy-service.log
```

I created the log file and gave the service user permission to write to it:

```bash
sudo touch /var/log/dummy-service.log
sudo chown kairat:kairat /var/log/dummy-service.log
```

Then I reloaded systemd and started the service:

```bash
sudo systemctl daemon-reload
sudo systemctl enable dummy
sudo systemctl start dummy
```

I checked the service and logs using:

```bash
sudo systemctl status dummy
sudo journalctl -u dummy -f
```
