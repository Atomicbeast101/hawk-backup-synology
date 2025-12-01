# HawkBackup - Synology Config Backup

Simple Ansible playbook to backup config from Synology NAS devices.

Works with the following Synology NAS so far (others should work as long as SSH access is available & `synoconfbkp` command exists):
- Synology DS224+
- Synology DS423
- Synology DS423+

## Setup

Synology NAS must have SSH enabled for an admin account to run the following commands:
    - `sudo /usr/syno/bin/synoconfbkp export --filepath=/tmp/<auto_generated_filename>.dss`
    - `sudo rm /tmp/<auto_generated_filename>.dss` (file will be downloaded to host running Ansible playbook before executing this)

Once the environment variables are set (see below for details), run it via Docker-compatible environment such as Synology, Kubernetes, etc:
```bash
docker run adam/hawk-backup-switch:latest
```

## Environment Variables

| Environment Variable | Description | Default |
| :------- | :------ | :-------: |
| SYNOLOGY_HOST | FQDN/IP address of Synology to perform config backup. | N/A |
| SYNOLOGY_PORT | Port of Synology SSH. | 22 |
| SYNOLOGY_USERNAME | Username for Synology SSH access. | N/A |
| SYNOLOGY_PASSWORD | Password for Synology SSH access. | N/A |
| SFTP_HOST | FQDN/IP address of SFTP server to send downloaded config file to. | N/A |
| SFTP_PORT | Port of SFTP server. | 22 |
| SFTP_USERNAME | Username for SFTP server. | N/A |
| SFTP_PASSWORD | Password for SFTP server. | N/A |
| SFTP_PATH | Destination path in SFTP server to store config file in. | N/A |
| PUSHOVER_USER_KEY | User key for Pushover notifications. Gets sent out for failed backups. | N/A |
| PUSHOVER_APP_TOKEN | App token for Pushover notifications. Gets sent out for failed backups. | N/A |
