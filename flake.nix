{
  description = "Multifunctional 7 Segment Reborn Pebble watchface";

  inputs = {
    pebble.url = "github:pebble-dev/pebble.nix";
    nixpkgs.follows = "pebble/nixpkgs";
  };

  outputs =
    { nixpkgs, pebble, ... }:
    let
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forEachSystem =
        f:
        builtins.listToAttrs (
          map (system: {
            name = system;
            value = f system;
          }) systems
        );
    in
    {
      devShells = forEachSystem (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ pebble.overlays.default ];
          };
        in
        {
          default = pkgs.mkShellNoCC {
            packages = with pkgs; [
              nodejs
              pebble-tool
              pebble-toolchain-bin
            ];

            CFLAGS = "-fcommon -Wno-error=builtin-macro-redefined -Wno-error=builtin-declaration-mismatch -Wno-error=format-truncation -include sys/types.h";
            PEBBLE_EXTRA_PATH = pkgs.lib.makeBinPath [ pkgs.pebble-toolchain-bin ];
          };
        }
      );
    };
}
