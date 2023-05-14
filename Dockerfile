FROM alpine:3.14

# Install bash, curl and busybox-cron
RUN apk add --no-cache bash curl busybox-initscripts

WORKDIR /app

# Copy script and crontab files
COPY script.sh crontab /app/

# Add crontab file
COPY crontab /var/spool/cron/crontabs/root

# Give execution rights on the cron job
RUN chmod 0644 /var/spool/cron/crontabs/root

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Run the command on container startup
CMD ["crond", "-f"]
