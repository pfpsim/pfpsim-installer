# PFPSim Framework Installer

A small GUI for the installation of the PFPSim Framework.

![installer-pfpsim](https://cloud.githubusercontent.com/assets/2020096/15365717/40d4084e-1cef-11e6-91a9-d07b60546237.gif)

## Before you get started:

Due to SystemC's licensing terms, it must be downloaded manually. Download it from this [page](http://accellera.org/downloads/standards/systemc). Follow the link for "SystemC 2.3.1 (Includes TLM) | Core SystemC Language and Examples".

**Important Note: The downloaded *.tar should be placed along side the files in this repository.**

## Installation Configuration:

The installer will set up your system with the following configuration. Versions otherwise mentioned of packages installed will be those that the package manager of your distribution installs.

__NOTE : ALL C++ SOURCES WILL BE BUILT WITH CLANG/LLVM BY THIS INSTALLER__

|Category     |  Toolchain          |
|:-----------:|---------------------|
|C++ Compiler     | Clang/LLVM, libstdc++, flexc++, bisonc++ |
|Python | From package-manager  |
|Build Tools  | CMake, Make |
|IPC          | Nanomsg V0.5-beta, Protobuf V2.6.1 |
|SystemC      | Provided by User |

For list of complete packages installed see [here](https://github.com/pfpsim/pfpsim-installer#packages-installed)

## Installation Options:

The following packages are available:
- [PFPSim Depedencies](https://github.com/pfpsim/PFPSim#dependencies)
- [SystemC](http://accellera.org/downloads/standards/systemc)
- [PFPSim Runtime Library](https://github.com/pfpsim/PFPSim)
- [`pfpgen`](https://github.com/pfpsim/pfpgen)
- [`pfpdb`](https://github.com/pfpsim/pfpdb)
- [P4 runtime environment for PFPSim](https://github.com/pfpsim/p4-behavioral-model#dependencies)

# Installing:

## <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/35/Tux.svg/204px-Tux.svg.png" width="25px"> </img> Linux:

### <img src="https://upload.wikimedia.org/wikipedia/commons/4/4a/Debian-OpenLogo.svg" width="25px"> Debian/Ubuntu:

Clone this repository and run the pfpsim-installer script.

**Note**: don't forget to [manually download the SystemC source](#before-you-get-started)

```
git clone https://github.com/pfpsim/pfpsim-installer.git
cd pfpsim-installer
sudo ./pfpsim-installer.sh
```

*Administrator privileges are required since components are installed globally*

During install if you want to monitor the progress of a component install. Open another terminal window.

```
cd pfpsim-installer/log
ls
tail <component_name>.log
```

### Other:
Same instructions as above but scripts need to be modified with a simple find/replace for apt-get with the package manager for your distribution.
For example, for Fedora you could easily use `sed` to replace `apt-get` with `dnf`:

```sh
find . -name '*.sh' -exec sed -i 's/apt-get/dnf/' \{\} \;
```

<sup>(note that this is untested) :wink:</sup>

## OSX/Windows/Others:

All dependencies must be satisfied for each tool first.
- [PFPSim Runtime Library](https://github.com/pfpsim/PFPSim)
- [`pfpgen`](https://github.com/pfpsim/pfpgen)
- [`pfpdb`](https://github.com/pfpsim/pfpdb)

You will need to install everything from source. We try our best not be tied to specific version or compiler tool chain. See repositories of each tool for more information.
Good Luck!

# Explore Examples

- [Simple NPU](https://github.com/pfpsim/simple-npu)  - An example model of a generic Network Processing Unit.
- [Simple RMT](https://github.com/pfpsim/simple-rmt)  - An example model of a Reconfigurable Match-Tables architecture.

# Packages Installed:

- PFPSim
 - cmake autoconf
 - g++ clang libpcap-dev libtool libc++abi1 libc++abi-dev libc++1 libc++-dev
 - flexc++ bisonc++
 - git doxygen
 - python, pip
 - Packages compiled from source:
   - Protobuf V2.6.1
    - Nanomsg V0.5-beta
    - Thrift V0.9.2
    - SystemC
      - Provided by user
- P4
 - automake libjudy-dev libgmp-dev libboost-dev libboost-test-dev libboost-program-options-dev libboost-system-dev libboost-filesystem-dev libboost-thread-dev libevent-dev libtool flex bison pkg-config libssl-dev mktemp libffi-dev python-dev python-pip
