{
  description = "LibGit2 bindings for Lua.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        luaPackages = pkgs.luaPackages.overrideScope (final: prev: {
          inherit lua;
          inherit (luaPackages.callPackage ./nixpkgs/lua { }) lua-json;
          inherit luagit2;
        });

        lua =
          pkgs.lua.override { packageOverrides = final: prev: luaPackages; };

        luagit2 = luaPackages.callPackage ./package.nix { };
      in {
        defaultPackage = luagit2;

        devShell = pkgs.mkShell {
          inputsFrom = [ luagit2 ];
          packages = [
            pkgs.luarocks-nix

            (lua.withPackages (ps: [ ps.luagit2 ps.lua-json ]))
          ];
        };
      });

}
