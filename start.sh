FILE=/etc/crontabs/root
if test -f "$FILE"; then
	chmod 0644 /etc/crontabs/root
	crontab /etc/crontabs/root
	touch /var/log/cron.log
	service cron restart
fi

php-fpm
