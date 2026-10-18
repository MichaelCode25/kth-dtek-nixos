{
  stdenv,
  fetchFromGitHub,
  quartus-prime-lite,
  autoPatchelfHook,
  ...
}:

stdenv.mkDerivation {
  name = "dtekv-tools";
  version = "1.0.0";

  src = fetchFromGitHub { 
    owner = "MichaelCode25";
    repo = "kth-dtekv-tools";
    rev = "5d1312fd2b01c97a71b8d2d5ce74e9a034aabcbb";
    sha256 = "sha256-o19aMuIsnVV+4eV9uMxhwIYTMZgKbVphnA2NATJsiY8=";
  };

  # Symlink required libraries to build directory + patch resulting executables with paths to dynamic libraries with "autoPatchelfHook"
  buildInputs = [ quartus-prime-lite.unwrapped ];
  nativeBuildInputs = [ autoPatchelfHook ];
  
  preBuild = ''
    ln -s ${quartus-prime-lite.unwrapped}/quartus/linux64/libjtag_atlantic.so .
    ln -s ${quartus-prime-lite.unwrapped}/quartus/linux64/libjtag_client.so .

    addAutoPatchelfSearchPath ${quartus-prime-lite.unwrapped}/quartus/linux64/
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp dtekv-run dtekv-upload dtekv-download $out/bin
    runHook postInstall
  '';
}