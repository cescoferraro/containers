#!/bin/bash
source /password.sh
if [ "${REDIS_PASS}" == "**Random**" ]; then
    unset REDIS_PASS
fi

# Set initial configuration
if [ ! -f /.redis_configured ]; then
    mkdir -p /etc/redis/
    touch /etc/redis/redis_default.conf

    if [ "${REDIS_PASS}" != "**None**" ]; then
        PASS=${REDIS_PASS:-${MYPASSWORD}}


        _word=$( [ ${REDIS_PASS} ] && echo "preset" || echo "random" )
        echo "=> Securing redis with a ${_word} password"
        echo "bind 0.0.0.0" >> /etc/redis/redis_default.conf
        echo "requirepass $PASS" >> /etc/redis/redis_default.conf
        echo "=> Done!"
        echo "========================================================================"
        echo "You can now connect to this Redis server using:"
        echo ""
        echo "    redis-cli -a $PASS -h <host> -p <port>"
        echo ""
        echo "Please remember to change the above password as soon as possible!"
        echo "========================================================================"
    fi

    unset REDIS_PASS

    # Backwards compatibility
    if [ ! -z "${REDIS_MODE}" ]; then
        echo "!! WARNING: \$REDIS_MODE is deprecated. Please use \$REDIS_MAXMEMORY_POLICY instead"
        if [ "${REDIS_MODE}" == "LRU" ]; then
            export REDIS_MAXMEMORY_POLICY=allkeys-lru
            unset REDIS_MODE
        fi
    fi

    echo "=> Using redis.conf:"
    cat /etc/redis/redis_default.conf | grep -v "requirepass"

    touch /.redis_configured
fi
echo "**********"
cat /etc/redis/redis_default.conf
exec /usr/local/bin/redis-server /etc/redis/redis_default.conf