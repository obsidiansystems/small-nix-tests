{ lib, buildPythonPackage, fetchPypi
, asttokens, colorama, executing, pygments
}:

buildPythonPackage rec {
  pname = "icecream";
  version = "2.1.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-CTALLRxnhxJBDL1HyVGY6xtYD2bzEaVUzNa551js4O4=";
  };

  propagatedBuildInputs = [ asttokens colorama executing pygments ];

  meta = with lib; {
    description = "A little library for sweet and creamy print debugging";
    homepage = "https://github.com/gruns/icecream";
    license = licenses.mit;
    maintainers = with maintainers; [ renatoGarcia ];
  };
}
