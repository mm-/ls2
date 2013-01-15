#!/bin/bash
# MySQL Login helper, broken out from ls-init.sh


function mysql_login() {

mysql_client=$( which mysql )
if [ -x $mysql_client ]; then
if [ -e /etc/psa/.psa.shadow ]; then
echo -e "[ls-scr] $brightyellow \bUsing Plesk's admin login. $norm"
mysql -u admin -p`cat /etc/psa/.psa.shadow`
else
if [ -e /root/.my.cnf ]; then
echo -e "[ls-scr] $brightwhite \bFound a local $brightyellow \bmy.cnf $brightwhite \bin root's homedir, attempting to login without password prompt. $norm"
$mysql_client
if [ "$?" -ne "0" ]; then
echo -e "[ls-scr] $brightred \bFailed! $norm \bprompting for MySQL root password.$norm"
fi
else
echo -e "[ls-scr] $brightmagenta \bCould not auto-detect MySQL root password - prompting.$norm"
$mysql_client -u root -p
if [ "$?" -ne "0" ]; then
echo -e "[ls-scr] $brightyellow \bMySQL authentication failed or program exited with error.$norm"
fi
fi
fi
else
echo -e "[ls-scr] $brightred\bCould not locate MySQL client in path.$norm"
fi
return 0;
}

mysql_login
