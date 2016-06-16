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


echo "Installing pfpsim dependencies..."

# Dependencies that can be apt-get'ed
sudo apt-get update

sudo apt-get install -y \
  cmake \
  git \
  g++ \
  clang \
  autoconf \
  libpcap-dev \
  libtool \
  libc++abi1 libc++abi-dev \
  libc++1 libc++-dev \
  flexc++ \
  bisonc++ \
  doxygen \

echo "Done installing pfpsim Apt-Get dependencies."
