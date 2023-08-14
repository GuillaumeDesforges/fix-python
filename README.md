# fix-python

Work with Python "normally" on NixOS in one command!

Tired of all these "*.so not found" errors?
Change the RPATH of all the binaries in your venv!

## Requirements

- Nix
- `nix-command` and `flakes` experimental features must be enabled

## Install

Use temporarly in a shell

```
nix shell github:GuillaumeDesforges/fix-python
```

Or add it to your profile

```
nix profile install github:GuillaumeDesforges/fix-python
```

## Usage

In your Python project, create a virtual environment `.venv` and use your preferred tool (pip, poetry, ...) to install your dependencies.

Then create a `.nix/libs.nix` file that returns the array of packages that you want binaries to be linked with.

> Note: you may add this `.nix` folder to your project `.gitignore`.

```nix
let pkgs = import (builtins.getFlake "nixpkgs") { };
in [
  pkgs.gcc.cc
  pkgs.glibc
  pkgs.zlib
]
```

> Note: these three packages are fundamental for most Python packages and should never me removed.

Finally, call `fix-python`.

```console
fix-python --venv .venv --libs .nix/libs.nix
```

See the list of options with

```
fix-python --help
```
