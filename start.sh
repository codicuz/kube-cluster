#!/bin/bash
./ansmenu.sh -prepareHost
./ansmenu.sh -yumKubeMaster
./ansmenu.sh -yumKubeNode
# ./ansmenu.sh -resetKubeCluster
./ansmenu.sh -fullInitKubeCluster
