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
	echo "Please enter hostname for sql db"
	read dbname
	echo "Please enter username for sql db"
	read user
	echo "Please enter password for sql db"
	read pass
}

check_sql

print_usage                       

export AUTOMATIONSTACK_HOST=$host
export AUTOMATIONSTACK_DATABASE=$dbname
export AUTOMATIONSTACK_USER=$user
export AUTOMATIONSTACK_PASSWORD=$pass




if [ $? -ne 0 ]; then

	echo "Error completing sql data population"
	exit 1
fi

echo "Done!"
