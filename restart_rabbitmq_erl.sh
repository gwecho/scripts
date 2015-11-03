#!/bin/sh

RABBIT_CMD_ROOT_PATH='/data1/ms/rabbitmq/rabbitmq_server-3.5.4/sbin/'

function restart_erlang()
{
    addr=$1
    port=$2
    ##stop_app
    addr_suffix=`echo $addr |awk -F '.' '{print $NF}'`
    rabbitmq_node_name=$port"@rabbitmq_node_"$addr_suffix
    stop_app_cmd=$RABBIT_CMD_ROOT_PATH"rabbitmqctl -n "$rabbitmq_node_name" stop_app"
    echo $stop_app_cmd
    $stop_app_cmd
    ##kill erlang process
    ps -ef|grep $rabbitmq_node_name|grep -v grep|awk '{print $2}'|xargs kill -9
    ##start erlang node
    RABBITMQ_NODE_IP_ADDRESS=$addr   RABBITMQ_NODE_PORT=$port  RABBITMQ_NODENAME=$port"@rabbitmq_node_"$addr_suffix  RABBITMQ_CONFIG_FILE=/data1/ms/rabbitmq/config/rabbitmq_$port   RABBITMQ_MNESIA_BASE=/data1/ms/rabbitmq/data/mnesia_$port   RABBITMQ_LOG_BASE=/data1/ms/rabbitmq/log    RABBITMQ_PLUGINS_DIR=/data1/ms/rabbitmq/rabbitmq_server-3.5.4/plugins    /data1/ms/rabbitmq/rabbitmq_server-3.5.4/sbin/rabbitmq-server -detached
}

function usage()
{
    echo "usage(): restart_rabbitmq.sh addr port"
    exit 1
}

if [ $# -lt 2 ]; then
    usage
fi

addr=$1
port=$2
echo "restart erlang $addr:$port"
restart_erlang $addr $port

exit 0
