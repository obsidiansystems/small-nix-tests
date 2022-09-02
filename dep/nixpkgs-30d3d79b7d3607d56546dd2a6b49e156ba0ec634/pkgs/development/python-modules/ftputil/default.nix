{ lib
, stdenv
, buildPythonPackage
, fetchPypi
, freezegun
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "ftputil";
  version = "5.0.3";
  format = "setuptools";

  disabled = pythonOlder "3.6";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-m4buZ8GYDOHYmxN1K8SLlJP+4GNJy0doKFlOduCPhIg=";
  };

  checkInputs = [
    freezegun
    pytestCheckHook
  ];

  disabledTests = [
    # Tests require network access
    "test_public_servers"
    "test_real_ftp"
    "test_set_parser"
    "test_upload"
  ];

  pythonImportsCheck = [
    "ftputil"
  ];

  meta = with lib; {
    description = "High-level FTP client library (virtual file system and more)";
    homepage = "http://ftputil.sschwarzer.net/";
    license = licenses.bsd2;
    maintainers = with maintainers; [ ];
  };
}