{
  outputs = { self, flake-utils, nixpkgs, ...}:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        {
          packages.default =
            pkgs.stdenv.mkDerivation {
              name = "fix-python";
              src = self;
              phases = [ "unpackPhase" "installPhase" ];
              installPhase = ''
                mkdir -p $out/bin
                cp $src/fix-python $out/bin
              '';
            };
        }
    );
}
