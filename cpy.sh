#!/bin/bash



add() {

echo "Oldal neve: "
read name
echo "Ne felejtsd el a www mappa tartalmát másolni a Copy funkcióval"
du='$uri'

path=/var/www/
og='"SAMEORIGIN"'
touch /var/www/chroot/etc/nginx/sites-available/$name.meraki.broadband.hu


echo "server {
    listen 80;
    listen [::]:80;

    server_name $name.meraki.broadband.hu;

    root $path$name.meraki.broadband.hu;
    index index.html;
    add_header X-Frame-Options $og;
    server_tokens off;


    location / {
        try_files $du $du/ =404;
    }
}
" > /var/www/chroot/etc/nginx/sites-available/$name.meraki.broadband.hu

chmod 644 /var/www/chroot/etc/nginx/sites-available/$name.meraki.broadband.hu
chown www-data:www-data /var/www/chroot/etc/nginx/sites-available/$name.meraki.broadband.hu
cp /var/www/chroot/etc/nginx/sites-available/$name.meraki.broadband.hu /var/www/chroot/etc/nginx/sites-enabled/$name.meraki.broadband.hu
chmod 644 /var/www/chroot/etc/nginx/sites-enabled/$name.meraki.broadband.hu
chown www-data:www-data /var/www/chroot/etc/nginx/sites-enabled/$name.meraki.broadband.hu


mkdir -p /var/www/chroot/var/www/$name.meraki.broadband.hu
chown -R www-data:www-data /var/www/chroot/var/www/$name.meraki.broadband.hu

rsync -avz /var/www/chroot/etc/nginx/ --rsync-path="sudo rsync" ladanyid@192.168.100.194:/var/www/chroot/etc/nginx/
rsync -avz /var/www/chroot/var/www/ --rsync-path="sudo rsync" ladanyid@192.168.100.194:/var/www/chroot/var/www/

}

dell() {


echo "Törlendő cucc neve: "
read dell

rm /var/www/chroot/etc/nginx/sites-available/$dell.meraki.broadband.hu
rm /var/www/chroot/etc/nginx/sites-enabled/$dell.meraki.broadband.hu

rm /var/www/chroot/var/www/$dell.meraki.broadband.hu/index.html
rmdir /var/www/chroot/var/www/$dell.meraki.broadband.hu


rsync -arv --delete /var/www/chroot/etc/nginx/sites-available/ --rsync-path="sudo rsync" ladanyid@192.168.100.194:/var/www/chroot/etc/nginx/sites-available/
rsync -arv --delete /var/www/chroot/etc/nginx/sites-enabled/ --rsync-path="sudo rsync" ladanyid@192.168.100.194:/var/www/chroot/etc/nginx/sites-enabled/
rsync -arv --delete /var/www/chroot/var/www/ --rsync-path="sudo rsync" ladanyid@192.168.100.194:/var/www/chroot/var/www/


}

list() {

ls /var/www/chroot/etc/nginx/sites-available/

}

restart() {
        /etc/init.d/nginx-chroot restart

}

copy() {

rsync -avz /var/www/chroot/var/www/ --rsync-path="sudo rsync" ladanyid@192.168.100.194:/var/www/chroot/var/www/

}

case "$1" in
        add)
            add
            ;;

        dell)
            dell
            ;;
        list)
            list
            ;;
        restart)
            restart
        ;;
    copy)
        copy
            ;;

         *)
            echo $"Hasznalat: $0 {add|dell|list|Nginx-restart|Copy}"
            exit 1

esac
