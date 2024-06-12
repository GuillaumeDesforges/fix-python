# fix-python

Work with Python "normally" on NixOS in one command!

Tired of all these "*.so not found" errors?
Change the RPATH of all the binaries in your venv!

## Requirements

- Nix
- `nix-command` and `flakes` experimental features must be enabled

## Install

Use temporarily in a shell

```
nix shell github:GuillaumeDesforges/fix-python
```

Or add it to your profile

```
nix profile install github:GuillaumeDesforges/fix-python
```

## Usage

In your Python project, create a virtual environment `.venv` and use your preferred tool (pip, poetry, ...) to install your dependencies.

By default, `fix-python` patches the packages given in the following expression:
```nix
let pkgs = import (builtins.getFlake "nixpkgs") { };
in [
  pkgs.gcc.cc
  pkgs.glibc
  pkgs.zlib
]
```

> Note: these three packages are fundamental for most Python packages and should never me removed.

If you need to patch packages in addition to these, create a `.nix/libs.nix` file with a structure similar to the above that returns the array of packages that you want binaries to be linked with.

> Note: you may add this `.nix` folder to your project `.gitignore`.

Finally, call `fix-python`.

```console
fix-python --venv .venv [--libs .nix/libs.nix]
```

The list of options is:

```
$ ./fix-python --help
Usage: fix-python --venv .venv [--libs libs.nix] [--no-default-libs]
--help: show this help message
--venv: path to Python virtual environment
--libs: path to a Nix file which returns a list of derivations
--no-default-libs: don't patch C++ standard libraries, glibc, and zlib by default
--gpu: enable GPU support
--with-torch: fix pytorch dependencies issues
--verbose: increase verbosity
```
