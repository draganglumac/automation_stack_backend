#!/bin/bash

function check_sql()
{
	version_message=`mysql --version`
	if [ $? -ne 0 ]; then
		echo "You need to have mysql installed on your machine."
		echo ""
		echo "Please install mysql and try again."
		
		exit -1
	fi
}
function print_usage()
{
	echo "Please enter hostname for sql db"
	read host
	echo "Please enter username for sql db"
	read user
	echo "Please enter password for sql sb"
	read pass
}

check_sql



if [ -z "$1" ]; then
	print_usage
	exit -1
fi
if [ -z "$2" ]; then
	print_usage
	exit -1
fi

if [ -z "$3" ]; then
	print_usage
	exit -1
fi

mysql -h$host -u$user -p$pass < build_db.sql


if [ $? -ne 0 ]; then

	echo "Error completing sql data population"
	exit 1
fi

echo "Done!"
