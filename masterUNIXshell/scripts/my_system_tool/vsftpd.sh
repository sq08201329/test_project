yum -y install vsftpd
echo 'anon_upload_enable=YES
anon_world_readable_only=YES
anon_mkdir_write_enable=YES
anon_other_write_enable=YES' >> /etc/vsftpd/vsftpd.conf
chmod o+w /var/ftp/pub/

sed -i.bak '/root/d' /etc/vsftpd/user_list /etc/vsftpd/ftpusers

service vsftpd restart
chkconfig vsftpd on

