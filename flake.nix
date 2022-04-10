{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/release-21.11";

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      buildDeps = with pkgs;
        [ autoreconfHook check cmake doxygen linuxHeaders pkg-config python3 ];
    in {
      defaultPackage.x86_64-linux = with pkgs; stdenv.mkDerivation {
        pname = "libevdev";
        version = "1.11.0";
	src = ./.;

	preConfigure = ''
	  ./autogen.sh
	'';

	dontUseCmakeConfigure = true;

        nativeBuildInputs = buildDeps;
      };

      devShell.x86_64-linux = with pkgs; mkShell {
        buildInputs = buildDeps;
      };
    };
}
