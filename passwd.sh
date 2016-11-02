#!/usr/bin/env bash
echo "export PASSWD=\"${PASSWD}\"" > mongo/password.sh
echo "export PASSWD=\"${PASSWD}\"" > redis/password.sh