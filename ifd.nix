# IFD example
# Cf. https://nixos.wiki/wiki/Import_From_Derivation
{ nonce # we want to make sure Nix actually builds the derivation,
        # instead of realizing from cache, which is achieved by
        # using different nonces for different derivations.
, buildInputs ? []
}:
let
  pkgs =
    let
      src = builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/30d3d79b7d3607d56546dd2a6b49e156ba0ec634.tar.gz";
        sha256 = "0x5j9q1vi00c6kavnjlrwl3yy1xs60c34pkygm49dld2sgws7n0a";
      };
    in import src {};

  # Create a derivation which, when built, writes some Nix code to
  # its $out path.
  derivation-to-import = pkgs.writeText "ifd-${nonce}.nix" ''
    pkgs: pkgs.stdenv.mkDerivation {
      name = "test-repo-smithy-ifd-${nonce}";
      buildInputs = [ ${toString buildInputs} ];
      src = pkgs.fetchurl {
        url = "https://github.com/runeksvendsen/test-repo-smithy/archive/79fb1e22122775a5b4718e1919768d02333df252.tar.gz";
        sha256 = "sha256:0yvmw2nd5apps7g8lpsxd0k6d7y8kyd9zvd4prwh5bfi8zxxn3r5";
      };
      installPhase = "mkdir -p $out ; echo ${nonce} > $out/ifd.txt";
    }
  '';

  # Import this derivation.
  imported-derivation = import derivation-to-import;
in imported-derivation pkgs
