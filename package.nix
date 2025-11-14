{ buildLuarocksPackage, luaAtLeast, luaOlder, libgit2, }:
buildLuarocksPackage rec {
  pname = "lua-git2";
  version = "scm-0";

  src = ./.;
  knownRockspec = ./rockspecs/lua-git2-${version}.rockspec;

  buildInputs = [ libgit2 ];

  externalDeps = [{
    name = "GIT2";
    dep = libgit2;
  }];

  disabled = luaOlder "5.1" || luaAtLeast "5.5";

  meta = {
    homepage = "https://github.com/libgit2/luagit2";
    description = "LibGit2 bindings for Lua.";
    license.fullName = "MIT";
  };
}
