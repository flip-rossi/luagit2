{ callPackage, buildLuarocksPackage, luaOlder }: {
  lua-json = callPackage ./lua-json.nix { };
}
