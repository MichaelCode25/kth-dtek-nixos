{ pkgs ? import <nixpkgs> { } }:

{
  dtekv-tools = pkgs.callPackage ./pkgs/dtekv-tools { };
  riscv32-unknown-elf = pkgs.callPackage ./pkgs/riscv32-unknown-elf { };
}