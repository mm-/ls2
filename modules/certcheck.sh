sck(){ c=`echo -e "$1\n$2"|grep -o '.*.crt'`;k=`echo -e "$1\n$2"|grep -o '.*.key'`;x=`(o(){ openssl $1 -noout -modulus -in $2|openssl md5;};o x509 $c;o rsa $k)|uniq|wc -l`;(( $x - 1 ))&&echo "Fail"||echo "Pass";}

sck $1 $2
