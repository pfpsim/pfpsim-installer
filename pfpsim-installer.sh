#!/bin/bash
#
# pfpsim-installer: Graphical installer for the PFPSim Framework
#
# Copyright (C) 2016 Concordia Univ., Montreal
#     Samar Abdi
#     Umair Aftab
#     Gordon Bailey
#     Faras Dewal
#     Shafigh Parsazad
#     Eric Tremblay
#
# Copyright (C) 2016 Ericsson
#     Bochra Boughzala
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
# 02110-1301, USA.
#


# Author: Lemniscate Snickets
#set -o xtrace

if [ ! "$(whoami)" == "root" ]
then
  echo "You must run this installer as root!"
  exit 1
fi

THE_CHOSEN=$(whiptail --title "PFPSIM Framework Installer" --checklist      \
    "Choose components to install" 15 60 10                                 \
    "Dependencies" "Compiler,systemlibs etc" ON                              \
    "SystemC" "Simulation Kernel" ON                                        \
    "P4Lib" "P4 Libraries" ON                                               \
    "LibPFPSIM" "C++ PFPSIM Runtime Library" ON                             \
    "PFPGEN" "FAD Compiler" ON                                              \
    "PFPDB" "PFP Debugger" ON 3>&1 1>&2 2>&3)

# Declare associative array
declare -A install_scripts

# Fill associative array. Key: Option, Value: Script to run
install_scripts=( ["Dependencies"]="install_pfpsim_deps_autofind_compiler.sh" \
    ["SystemC"]="install_systemc_autofind_compiler.sh" \
    ["P4Lib"]="install_pfp_p4.sh" \
    ["LibPFPSIM"]="install_pfpsim.sh" \
    ["PFPGEN"]="install_pfpgen.sh" \
    ["PFPDB"]="install_pfpdb.sh")

mkdir -p log
## Print associative array
#for i in "${!install_scripts[@]}"
#do
#  echo "key  : $i"
#  echo "value: ${install_scripts[$i]}"
#done

exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "The chosen ones: " $THE_CHOSEN
    IFS=' ' read -r -a optionsarray <<< "$THE_CHOSEN"

    echo "The Chosen ones seperated:"
    for element in "${optionsarray[@]}"
    do
        echo "$element"
    done

    NumSelectedOptions=${#optionsarray[@]}


    echo "Beginning Install"
    progress=0
    counter=0
    {
    mkdir -p log
    while [ $progress -ne $NumSelectedOptions ]
    do
    # Iterate over each option. Removes quotations.
    option="${optionsarray[progress]%\"}"
    option="${option#\"}"
    percent=$((200*$progress/$NumSelectedOptions % 2 + 100*$progress/$NumSelectedOptions))

cat <<EOF
XXX
$percent
Installing $option ...
XXX
EOF

    sudo ./${install_scripts[$option]} &> log/$option.log
    progress=$[$progress+1]
    done
    percent=$((200*$progress/$NumSelectedOptions % 2 + 100*$progress/$NumSelectedOptions))
    echo $percent
    sleep 1
    } | whiptail --title "PFPSIM Framework Installer" --gauge "Installing " 8 78 0
    echo "Install Completed"
else
    echo "You chose to exit - womp womp."
fi
