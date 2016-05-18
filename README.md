# PFPSIM Framework Installer

--------------------------------------------------------------------------------

A small GUI for the installation of the PFPSIM Framework.

## Before you get started:

Due to SystemC's licensing terms, it must be downloaded manually. Download it from this [page](http://accellera.org/downloads/standards/systemc). Follow the link for "SystemC 2.3.1 (Includes TLM) | Core SystemC Language and Examples".

The downloaded *.tar should be placed along side thie files in this repository.

## Installation Configuration:

|Category     |  Toolchain          |
|:-----------:|---------------------|
|Compiler     | Clang/LLVM, libstdc++, flexc++, bisonc++ |
|Build Tools  | CMake, Make |
|IPC          | Nanomsg V0.5-beta, Protobuf V2.6.1 |
|SystemC      | Provided by User |

For list of complete packages installed see [here]()

## Installation Options:

- [PFPSIM Depedencies](https://github.com/pfpsim/PFPSim#dependencies)
- [SystemC](http://accellera.org/downloads/standards/systemc)
- [PFPSIM Runtime Library](https://github.com/pfpsim/PFPSim)
- [PFPGEN](https://github.com/pfpsim/pfpgen)
- [PFPDB](https://github.com/pfpsim/pfpdb)
- [P4 runtime environment for PFPSIM](https://github.com/pfpsim/p4-behavioral-model#dependencies)

![installer-pfpsim](https://cloud.githubusercontent.com/assets/2020096/15365717/40d4084e-1cef-11e6-91a9-d07b60546237.gif)

#Installing:

## LINUX:

### Debian/Ubuntu:

Clone this repository and run the pfpsim-installer script.
```
git clone https://github.com/pfpsim/pfpsim-installer.git
cd pfpsim-installer
chmod +x *.sh
./pfpsim-installer.sh
```

During install if you want to monitor the progress of a component install. Open another terminal window.

```
cd pfpsim-installer/log
ls
tail <component name>.log

```
### Other:
Same instructions as above but scripts need to be modified with a simple find/replace for apt-get with the package manager for your distribution

## OSX/Windows/Others:

Won't support.
