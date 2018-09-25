# 420friend.ly

## Raspberry Pi Setup

1. Copy scripts

```bash
scp -r .pi/bin sam@sam.pi:~/
```

2. Local setup

```bash
# Set timezone to UTC
sudo timedatectl set-timezone UTC

# Create directories
mkdir -p /home/sam/420friendly/live/thumb/
```

3. Setup AWS

```bash
# Install
sudo apt-get install -y awscli

# Configure credentials
aws configure
```

4. Copy cron schedule

```bash
crontab -e
```

Paste the contents of `.pi/cron` into the editor.