{
  outputs = { flake-utils, nixpkgs, ...}:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        {
          packages.default =
            pkgs.writeShellApplication {
                name = "fix-python";
                runtimeInputs = [pkgs.file pkgs.patchelf];
                text = builtins.readFile ./fix-python;
            };
        }
    );
}
