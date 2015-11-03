# scripts
scripts,bash,python,perl.etc
scripts

Create restart_rabbitmq_erl.sh
mv restart_rabbitmq_erl.sh /usr/bin/restart_rabbitmq_erl
then I restart rabbitmq cluster though salt

salt minion-name cmd.run "sudo restart_rabbitmq_erl addr_node_1 port "
salt minion-name cmd.run "sudo restart_rabbitmq_erl addr_node_2 port "
......
