{ lib, mkCoqDerivation, coq, version ? null }:
with lib;

mkCoqDerivation {
  pname = "smpl";
  owner = "uds-psl";

  release."8.10.2".sha256 = "sha256-TUfTZKBgrSOT6piXRViHSGPE9NSj3bGx2XBIw6YCcEs=";
  release."8.12".sha256 = "sha256-UQbDHLVBKYk++o+Y2B6ARYRYGglytsnXhguwMatjOHg=";
  release."8.13".sha256 = "sha256-HxQBaIE2CjyfG4GoIXprfehqjsr/Z74YdodxMmrbzSg=";
  releaseRev = v: "v${v}";

  inherit version;
  defaultVersion = with versions; switch coq.version [
    { case = "8.13.2"; out = "8.13"; }
    { case = "8.12.2"; out = "8.12"; }
    { case = "8.10.2"; out = "8.10.2"; }
  ] null;

  mlPlugin = true;

  meta = {
    description = "A Coq plugin providing an extensible tactic similar to first";
    maintainers = with maintainers; [ siraben ];
    license = licenses.mit;
    platforms = platforms.unix;
  };
}