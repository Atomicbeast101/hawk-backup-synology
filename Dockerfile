FROM alpine:3.22

# Dependencies
COPY packages.txt /tmp/packages.txt
RUN apk update && apk add --no-cache $(awk '{print $1}' /tmp/packages.txt)
RUN ssh-keygen -t rsa -b 4096 -N "" -f /root/.ssh/id_rsa

# Environment Variables
ENV REQUIRED_VARS="SYNOLOGY_HOST SYNOLOGY_USERNAME SYNOLOGY_PASSWORD SFTP_HOST SFTP_USERNAME SFTP_PASSWORD SFTP_PATH PUSHOVER_USER_KEY PUSHOVER_APP_TOKEN"
ENV CRON_SCHEDULE="0 0 * * *"
ENV SYNOLOGY_PORT=22
ENV SFTP_PORT=22

# Start App
WORKDIR /app
COPY requirements.txt .
COPY requirements.yml .
COPY playbook.yml .
COPY *.sh .
RUN chmod +x /app/*.sh
CMD ["./docker-entrypoint.sh"]
