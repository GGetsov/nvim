{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell
{
  nativeBuildInputs = with pkgs; [
    lua-language-server
    stylua

    # nixd
  ];

  shellHook = ''
    nvim .
  '';
}
