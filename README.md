# scripts
scripts,bash,python,perl.etc

script list

[restart_rabbitmq_erl.sh]

    mv restart_rabbitmq_erl.sh /usr/bin/restart_rabbitmq_erl
    then I restart rabbitmq cluster though salt:

    salt minion-name cmd.run "sudo restart_rabbitmq_erl addr_node_1 port "
    salt minion-name cmd.run "sudo restart_rabbitmq_erl addr_node_2 port "
    ......

    done with restart_rabbitmq_erl.sh
