{ pkgs ? import <nixpkgs> { } }:

{
  dtekv-tools = pkgs.callPackage ./pkgs/dtekv-tools { };
}