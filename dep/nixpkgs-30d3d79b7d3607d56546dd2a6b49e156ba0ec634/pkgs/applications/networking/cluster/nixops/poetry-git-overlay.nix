{ pkgs }:
self: super: {

  nixops = super.nixops.overridePythonAttrs (
    _: {
      src = pkgs.fetchgit {
        url = "https://github.com/NixOS/nixops.git";
        rev = "7220cbdc8a1cf2db5b3ad75b525faf145a5560a3";
        sha256 = "199cw25cvjb8gxs56nc8ilq7v4560c6vgi1sh1vqrsqxayq1g4cs";
      };
    }
  );

  nixops-aws = super.nixops-aws.overridePythonAttrs (
    _: {
      src = pkgs.fetchgit {
        url = "https://github.com/NixOS/nixops-aws.git";
        rev = "bc9de10b77aa74c9b245fd533f829e4307b984e8";
        sha256 = "12qsaxwlk67q04g13sqs4bxscpjspip5yphx6d8rq3iqki8yg4z9";
      };
    }
  );

  nixops-digitalocean = super.nixops-digitalocean.overridePythonAttrs (
    _: {
      src = pkgs.fetchgit {
        url = "https://github.com/nix-community/nixops-digitalocean.git";
        rev = "b527b4bd27a419753e38c8231fd7528b3ea33886";
        sha256 = "069jlgcjqgyb1v3dnrp2h0w4gv5hfx624iq2xazaix2wxpx9w7f8";
      };
    }
  );

  nixops-encrypted-links = super.nixops-encrypted-links.overridePythonAttrs (
    _: {
      src = pkgs.fetchgit {
        url = "https://github.com/nix-community/nixops-encrypted-links.git";
        rev = "e2f196fce15fcfb00d18c055e1ac53aec33b8fb1";
        sha256 = "12ynqwd5ad6wfyv6sma55wnmrlr8i14kd5d42zqv4zl23h0xnd6m";
      };
    }
  );

  nixops-gcp = super.nixops-gcp.overridePythonAttrs (
    _: {
      src = pkgs.fetchgit {
        url = "https://github.com/nix-community/nixops-gce.git";
        rev = "712453027486e62e087b9c91e4a8a171eebb6ddd";
        sha256 = "0siw2silxvbxdfgb2dcymn11nqdf8an7q43wcq1lyg1ac07w7dwh";
      };
    }
  );

  nixops-hercules-ci = super.nixops-hercules-ci.overridePythonAttrs (
    _: {
      src = pkgs.fetchgit {
        url = "https://github.com/hercules-ci/nixops-hercules-ci.git";
        rev = "e601d5baffd003fd5f22deeaea0cb96444b054dc";
        sha256 = "0rcpv5hc6l9ia8lq8ivwa80b2pwssmdz8an25lhr4i2472mpx1p0";
      };
    }
  );

  nixops-hetzner = super.nixops-hetzner.overridePythonAttrs (
    _: {
      src = pkgs.fetchgit {
        url = "https://github.com/NixOS/nixops-hetzner";
        rev = "84f4eebb89b049c4f86aa779349397c3dedc0c43";
        sha256 = "0qx8v775jhlbqyhid8wkzy3xcha08kkzb42h6ayszwq4alyfx0b0";
      };
    }
  );

  nixops-virtd = super.nixops-virtd.overridePythonAttrs (
    _: {
      src = pkgs.fetchgit {
        url = "https://github.com/lovesegfault/nixops-libvirtd.git";
        rev = "84d1688ee06afff136738b3eaf51f9cc3c08c350";
        sha256 = "1f3q9bwmdjr3qac7fh9b9hgw7l43hmiixbsmqm2zrnhb7xcyfmfg";
      };
    }
  );

  nixopsvbox = super.nixopsvbox.overridePythonAttrs (
    _: {
      src = pkgs.fetchgit {
        url = "https://github.com/nix-community/nixops-vbox.git";
        rev = "2729672865ebe2aa973c062a3fbddda8c1359da0";
        sha256 = "07bmrbg3g2prnba2kwg1rg6rvmnx1vzc538y2q3g04s958hala56";
      };
    }
  );

  nixos-modules-contrib = super.nixos-modules-contrib.overridePythonAttrs (
    _: {
      src = pkgs.fetchgit {
        url = "https://github.com/nix-community/nixos-modules-contrib.git";
        rev = "81a1c2ef424dcf596a97b2e46a58ca73a1dd1ff8";
        sha256 = "0f6ra5r8i1jz8ymw6l3j68b676a1lv0466lv0xa6mi80k6v9457x";
      };
    }
  );

}