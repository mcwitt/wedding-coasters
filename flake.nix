{
  description = "Art for laser-cut wedding coasters";
  inputs.nixpkgs.url = "nixpkgs";
  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs {
        inherit system;
        overlays = [ self.overlay ];
      });
    in
    {
      overlay = (final: _: {
        wedding-coasters = final.haskellPackages.callCabal2nix "wedding-coasters" ./. { };
      });
      packages = forAllSystems (system: {
        wedding-coasters = nixpkgsFor.${system}.wedding-coasters;
      });
      defaultPackage = forAllSystems (system: self.packages.${system}.wedding-coasters);
      checks = self.packages;
      devShell = forAllSystems (system:
        let haskellPackages = nixpkgsFor.${system}.haskellPackages;
        in
        haskellPackages.shellFor {
          packages = _: [ self.packages.${system}.wedding-coasters ];
          withHoogle = true;
          buildInputs = with haskellPackages; [
            haskell-language-server
            ghcid
            cabal-fmt
            cabal-install
            ormolu
          ];
        });
    };
}
