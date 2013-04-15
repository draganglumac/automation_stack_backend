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
function update_build_xml()
{
    host=$1
    dbname=$2
    user=$3
    pass=$4
    seedconf=$5

    pushd "database/migrations"

    cat build.xml.preset | sed "s/HOSTNAME/$host/g" | sed "s/DATABASE/$dbname/g" | sed "s/USERNAME/$user/g" | sed "s/PASSWORD/$pass/g" | sed "s/SEED_CONFIG/$seedconf/g" > build.xml
    popd
    echo "Updated build xml"
}

check_sql

if [ $1 ] && [ $2 ] && [ $3 ] && [ $4 ] && [ $5 ]; then 
    echo "Using commandline args"
    echo " HOST DB USER PASS CONF_SEED "
    echo "AUTOMATION_HOST: $1" >> settings.yaml
    echo "AUTOMATION_DB: $2" >> settings.yaml
    echo "AUTOMATION_USER: $3" >> settings.yaml
    echo "AUTOMATION_PASS: $4" >> settings.yaml
    echo "SEED_CONFIG: $5" >> settings.yaml
    update_build_xml $1 $2 $3 $4 $5
else
    echo "Please enter hostname for sql db"
    read host
    echo "Please enter database for sql db"
    read dbname
    echo "Please enter username for sql db"
    read user
    echo "Please enter password for sql db"
    read pass
    echo "Please enter seed configuration (dev, test, prod)"
    read seedconf

    echo "AUTOMATION_HOST: $host" > settings.yaml
    echo "AUTOMATION_DB: $dbname" >> settings.yaml
    echo "AUTOMATION_USER: $user" >> settings.yaml
    echo "AUTOMATION_PASS: $pass" >> settings.yaml
    echo "SEED_CONFIG: $seedconf" >> settings.yaml
    update_build_xml $host $dbname $user $pass $seedconf
fi

bundle install

rake verify 

if [ $? -ne 0 ]; then

    echo "Error completing sql data population"
    exit 1
fi

rake

echo "Done!"
