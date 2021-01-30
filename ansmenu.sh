#!/bin/bash

NO_ARGS=0
E_OPTERR=65
TARGET=$2
FLAGADMIN=$3
FLAGDBA=$4
FLAGNEVA=$5

if [ $# -eq "$NO_ARGS" ]
then
  printf "Отсутствуют аргументы. Должен быть хотя бы один аргумент.\n"
  printf "Использование: $0 {-build|-rmi|-none|-rmfa|-run|-restart|-rmf|-exec|-exec0|-logsf}\n"
  printf " $0 -run - bla bla bla"
  exit $E_OPTERR
fi

case "$1" in
-runDeploy)
	ansible-playbook -i inventory.yml initial-runDeploy.yml
	;;
-aptKubeMaster)
	ansible-playbook -i inventory.yml initial-aptKubeMaster.yml
	;;
-yumKubeMaster)
	ansible-playbook -i inventory.yml initial-yumKubeMaster.yml
	;;
-yumKubeNode)
	ansible-playbook -i inventory.yml initial-yumKubeNode.yml
	;;
-getFiles)
	ansible-playbook -i inventory.yml -e target=$TARGET initial-getFiles.yml
	;;
-knownHosts)
	ansible-playbook -i inventory.yml initial-knownHosts.yml
	;;
-realmConfig)
	ansible-playbook -i inventory.yml -e target=$TARGET initial-realmConfig.yml
	;;
-fixhosts)
	ansible-playbook -i inventory.yml -e target=$TARGET initial-fixhosts.yml
	;;
-addAdminUser)
	ansible-playbook -i inventory.yml -e target=$TARGET -e admin=$FLAGADMIN -e dba=$FLAGDBA -e neva=$FLAGNEVA initial-addAdminUser.yml
	;;
-addUser)
	ansible-playbook -i inventory.yml -e target=$TARGET initial-addUser.yml
	;;
-removeUser)
	ansible-playbook -i inventory.yml -e target=$TARGET initial-removeUser.yml
	;;
-addGroupDocker)
	ansible-playbook -i inventory.yml -e target=$TARGET initial-addGroupDocker.yml
	;;
-modifyUserGroupAppend)
	ansible-playbook -i inventory.yml -e target=$TARGET initial-modifyUserGroupsAppend.yml
	;;
-copymirrorrepo)
	ansible-playbook -i inventory.yml -e target=$TARGET initial-copyfiles.yml
	;;
-updateAllPackages)
	ansible-playbook -i inventory.yml -e target=$TARGET initial-updateAllPackages.yml
	;;
-installPackages)
	ansible-playbook -i inventory.yml -e target=$TARGET initial-installPackages.yml
	;;
-installDockerCe)
	ansible-playbook -i inventory.yml -e target=$TARGET initial-installDockerCe.yml
	;;
-swapOff)
	ansible-playbook -i inventory.yml -e target=$TARGET initial-swapOff.yml
	;;
-initKubeCluster)
	ansible-playbook -i inventory.yml -e target=$TARGET initial-initKubeCluster.yml
	;;
-resetKubeCluster)
	ansible-playbook -i inventory.yml initial-resetKubeCluster.yml
	;;
-prepareHost)
	ansible-playbook -i inventory.yml initial-prepareHost.yml
	;;
-joinNodes)
	ansible-playbook -i inventory.yml -e target=$TARGET initial-joinNodes.yml
	;;
-fullInitKubeCluster)
	ansible-playbook -i inventory.yml initial-fullInitKubeCluster.yml
	;;
-removePackages)
	ansible-playbook -i inventory.yml -e target=$TARGET initial-removePackages.yml
	;;
-configureDocker)
	ansible-playbook -i inventory.yml -e target=$TARGET initial-configureDocker.yml
	;;
-testrole)
	ansible-playbook -i inventory.yml -e target=$TARGET initial-testrole.yml
	;;
-whoami)
	ansible-playbook -i inventory.yml -e target=$TARGET initial-whoami.yml
	;;
-ping)
	ansible -i inventory.yml -m ping all
	;;
-genpasswd)
	ansible all -i localhost, -m debug -a "msg={{ 'pincode' | password_hash('sha512', 'ssdffdss') }}"
	;;
?* | -?*)
	printf 'ПРЕДУПРЕЖДЕНИЕ: Неизвестный аргумент (проигнорировано): %s\n' "$1" >&2
	;;
*)
	break
esac

exit 0
