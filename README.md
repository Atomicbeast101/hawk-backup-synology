# HawkBackup - Synology Config Backup

Simple Ansible playbook to backup config from Synology NAS devices.

Works with the following Synology NAS so far (others should work as long as SSH access is available & `synoconfbkp` command exists):
- Synology DS224+
- Synology DS423
- Synology DS423+

## Requirements

* Synology NAS must have SSH enabled for an admin account.
* `/usr/syno/bin/synoconfbkp` command exists in Synology NAS CLI.

## How it Works

Whenever the cron schedule hits, it runs an Ansible playbook that does the following:
1) Create `/app/.downloads` folder.
2) Remove the existing generated config file from `/tmp` folder if it exists.
3) Run the following command to generate the config file:
```bash
/usr/syno/bin/synoconfbkp export --filepath=/tmp/<auto_generated_filename>.dss
```
4) Download config to `/app/.downloads` from Synology NAS's `/tmp` folder.
5) Remove generated config file from `/tmp` folder.
6) Uploads that config file to SFTP endpoint.
7) Removes the config file from `/app/.downloads`.

If any of the tasks above fails, a Pushover notification will be sent stating that the backup failed for a specific synology (by hostname).

## Setup - Docker

Here's an example of how to run this application in Docker:

```bash
docker run \
    -e SYNOLOGY_HOST=nas.example.com \
    -e SYNOLOGY_USERNAME=admin \
    -e SYNOLOGY_PASSWORD=<password> \
    -e SFTP_HOST=sftp.example.com \
    -e SFTP_USERNAME=backup \
    -e SFTP_PASSWORD=<password> \
    -e SFTP_PATH="/path/to/directory" \
    -e PUSHOVER_USER_KEY=<user_key> \
    -e PUSHOVER_APP_TOKEN=<user_password> \
    ghcr.io/atomicbeast101/hawk-backup-synology:latest
```

More details on the environment variables can be found below.

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
