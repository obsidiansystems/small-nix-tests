{ stdenv, lib, fetchFromGitHub
, fetchpatch
, asciidoc
, brotli
, cmake
, graphviz
, doxygen
, giflib
, gperftools
, gtest
, libhwy
, libjpeg
, libpng
, libwebp
, openexr
, pkg-config
, python3
, zlib
}:

stdenv.mkDerivation rec {
  pname = "libjxl";
  version = "0.6.1";

  src = fetchFromGitHub {
    owner = "libjxl";
    repo = "libjxl";
    rev = "v${version}";
    sha256 = "sha256-fTK5hyU9PZ6nigMsfzVugwviihgAXfEcLF+l+n5h+54=";
    # There are various submodules in `third_party/`.
    fetchSubmodules = true;
  };

  patches = [
    # present in master, remove after 0.7?
    (fetchpatch {
      name = "fix-link-lld-macho.patch";
      url = "https://github.com/libjxl/libjxl/commit/88fe3fff3dc70c72405f57c69feffd9823930034.patch";
      sha256 = "1419fyiq4srpj72cynwyvqy8ldi7vn9asvkp5fsbmiqkyhb15jpk";
    })

    # "robust statistics" have been removed in upstream mainline as they are
    # conidered to cause "interoperability problems". sure enough the tests
    # fail with precision issues on aarch64.
    (fetchpatch {
      name = "remove-robust-and-descriptive-statistics.patch";
      url = "https://github.com/libjxl/libjxl/commit/204f87a5e4d684544b13900109abf040dc0b402b.patch";
      sha256 = "sha256-DoAaYWLmQ+R9GZbHMTYGe0gBL9ZesgtB+2WhmbARna8=";
    })
  ];

  nativeBuildInputs = [
    asciidoc # for docs
    cmake
    graphviz # for docs via doxygen component `dot`
    doxygen # for docs
    gtest
    pkg-config
    python3 # for docs
  ];

  # Functionality not currently provided by this package
  # that the cmake build can apparently use:
  #     OpenGL/GLUT (for Examples -> comparison with sjpeg)
  #     viewer (see `cmakeFlags`)
  #     plugins like for GDK and GIMP (see `cmakeFlags`)

  # Vendored libraries:
  # `libjxl` currently vendors many libraries as git submodules that they
  # might patch often (e.g. test/gmock, see
  # https://github.com/NixOS/nixpkgs/pull/103160#discussion_r519487734).
  # When it has stabilised in the future, we may want to tell the build
  # to use use nixpkgs system libraries.

  # As of writing, libjxl does not point out all its dependencies
  # conclusively in its README or otherwise; they can best be determined
  # by checking the CMake output for "Could NOT find".
  buildInputs = [
    brotli
    giflib
    gperftools # provides `libtcmalloc`
    libhwy
    libjpeg
    libpng
    libwebp
    openexr
    zlib
  ];

  cmakeFlags = [
    # For C dependencies like brotli, which are dynamically linked,
    # we want to use the system libraries, so that we don't have to care about
    # installing their .so files generated by this build.
    # The other C++ dependencies are statically linked in, so there
    # using the vendorered ones is easier.
    "-DJPEGXL_FORCE_SYSTEM_BROTLI=ON"

    # Use our version of highway, though it is still statically linked in
    "-DJPEGXL_FORCE_SYSTEM_HWY=ON"

    # TODO: Update this package to enable this (overridably via an option):
    # Viewer tools for evaluation.
    # "-DJPEGXL_ENABLE_VIEWERS=ON"

    # TODO: Update this package to enable this (overridably via an option):
    # Enable plugins, such as:
    # * the `gdk-pixbuf` one, which allows applications like `eog` to load jpeg-xl files
    # * the `gimp` one, which allows GIMP to load jpeg-xl files
    # "-DJPEGXL_ENABLE_PLUGINS=ON"
  ];

  LDFLAGS = lib.optionalString stdenv.hostPlatform.isRiscV "-latomic";

  doCheck = true;

  # The test driver runs a test `LibraryCLinkageTest` which without
  # LD_LIBRARY_PATH setting errors with:
  #     /build/source/build/tools/tests/libjxl_test: error while loading shared libraries: libjxl.so.0
  # The required file is in the build directory (`$PWD`).
  preCheck = if stdenv.isDarwin then ''
    export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH''${DYLD_LIBRARY_PATH:+:}$PWD
  '' else ''
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH''${LD_LIBRARY_PATH:+:}$PWD
  '';

  meta = with lib; {
    homepage = "https://github.com/libjxl/libjxl";
    description = "JPEG XL image format reference implementation.";
    license = licenses.bsd3;
    maintainers = with maintainers; [ nh2 ];
    platforms = platforms.all;
  };
}