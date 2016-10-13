#!/bin/bash
source /password.sh
set -m

mongodb_cmd="mongod --storageEngine $STORAGE_ENGINE"
cmd="$mongodb_cmd --httpinterface --rest --master"
USER=${MONGODB_USER:-"admin"}
DATABASE=${MONGODB_DATABASE:-"admin"}
PASS=${MONGODB_PASS:-${MYPASSWORD}}


if [ "$AUTH" == "yes" ]; then
    cmd="$cmd --auth"
fi

if [ "$JOURNALING" == "no" ]; then
    cmd="$cmd --nojournal"
fi

if [ "$OPLOG_SIZE" != "" ]; then
    cmd="$cmd --oplogSize $OPLOG_SIZE"
fi

$cmd &

if [ ! -f /data/db/.mongodb_password_set ]; then
    RET=1
    while [[ RET -ne 0 ]]; do
        echo "=> Waiting for confirmation of MongoDB service startup"
        sleep 5
        mongo admin --eval "help" >/dev/null 2>&1
        RET=$?
    done

    echo "=> Creating a root ${USER} user in MongoDB"

    mongo admin --eval  "db.createUser({user: '$USER', pwd: '$PASS', roles: ['userAdminAnyDatabase', 'dbAdminAnyDatabase', 'readWriteAnyDatabase']  });"
    mongo admin -u $USER -p $PASS --eval  "db.getSiblingDB('iot').createUser({user:'iot', pwd: '$PASS',roles:['readWrite']})"

    echo "=> Done!"
    touch /data/db/.mongodb_password_set

    echo "========================================================================"
    echo "You can now connect to this MongoDB server using:"
    echo ""
    echo "    mongo $DATABASE -u $USER -p $PASS --host <host> --port <port>"
    echo ""
    echo "Please remember to change the above password as soon as possible!"
    echo "========================================================================"
fi

fg
