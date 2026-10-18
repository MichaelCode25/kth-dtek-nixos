{
  pkgsCross,
  symlinkJoin,
  ...
}:

symlinkJoin {
  name = "riscv32-unknown-elf-toolchain";
  paths = [ pkgsCross.riscv32-embedded.stdenv.cc ];
  postBuild = ''
    for bin in $out/bin/riscv32-none-elf-*; do
      if [ -e "$bin" ]; then
        name=$(basename "$bin")
        newname="riscv32-unknown-elf-''${name#riscv32-none-elf-}"
        ln -s "$bin" "$out/bin/$newname"
      fi
    done
  '';
}

/*
Alright, alright. I know what you might be thinking: What the hell am I looking at?

So in short, nixpkgs *does* have the toolchain that we need for riscv32 development and such,
but it if you were to download it via `pkgs.pkgsCross.riscv32-embedded.buildPackages.gcc`,
you would get it under the name `riscv32-none-elf-...` instead of `riscv32-unknown-elf-...`.

This is a problem for us, since all makefiles that come with the assignments assume that
you are using `riscv32-unknown-elf-...`, and will not work with `riscv32-none-elf-...` just
because of the name difference. 

So, the solution is to just create a new derivation where we simply symlink the 
`riscv32-none-elf-...` binaries to corresponding `riscv32-unknown-elf-...` names :D

It seems to work without issues from my testing, but if you do find problems with this approach,
just open an issue. The benefit to doing this over for example compiling `riscv32-unknown-elf-...`
from source, is that `riscv32-none-elf-...` is cached in nixpkgs's chaches, so the user won't have
to compile it!
*/