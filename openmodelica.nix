{ stdenv, fetchgit, fetchsvn, autoconf, automake, libtool, gfortran, clang, cmake, gnumake, hwloc, jre, openblas, hdf5, expat, ncurses
, readline, qt4, webkitgtk, which, lp_solve, omniorb, sqlite, libatomic_ops, pkgconfig, file, gettext, flex, bison, doxygen, boost
, openscenegraph, gnome2, xorg, git, bash, gtk2, makeWrapper }:
let
  fakegit = import openmodelica/fakegit.nix {inherit stdenv fetchgit fetchsvn bash;} ;
in stdenv.mkDerivation {
  name = "openmodelica";

  src = pkgs.fetchFromGitHub {
    owner = "OpenModelica";
    repo = "OpenModelica";
    rev = "caa56f91529dfdf4962b3fc2e5dfe13f5e160eb7";
    sha256 = "06gx9sd7m8wjj8yvjfad1qxzk8yrsyyjzv6w9gpp30mvcll94pm9";
    fetchSubmodules = true;
  };

  buildInputs = [autoconf cmake automake libtool gfortran clang gnumake
    hwloc jre openblas hdf5 expat ncurses readline qt4 webkitgtk which
    lp_solve omniorb sqlite libatomic_ops pkgconfig file gettext flex bison
    doxygen boost openscenegraph gnome2.gtkglext xorg.libXmu
    git gtk2 makeWrapper ];

  hardeningDisable = [ "format" ];

  enableParallelBuilding = false;

  patchPhase = ''
    cp -fv ${fakegit}/bin/checkout-git.sh libraries/checkout-git.sh
    cp -fv ${fakegit}/bin/checkout-svn.sh libraries/checkout-svn.sh
  '';

  configurePhase = ''
    export NIX_LDFLAGS="$NIX_LDFLAGS -L${gfortran.cc.lib}/lib"

    autoconf
    ./configure CC=${clang}/bin/clang CXX=${clang}/bin/clang++ --prefix=$out --with-lapack="-lopenblas"
  '';

  postFixup = ''
    for e in $(cd $out/bin && ls); do
      if [ "$e" = "StartTLMFmiWrapper" ]; then continue; fi
      wrapProgram $out/bin/$e \
        --prefix PATH : "${gnumake}/bin" \
        --prefix LIBRARY_PATH : "${stdenv.lib.makeLibraryPath [ openblas ]}"
    done
  '';

  meta = with stdenv.lib; {
    description = "OpenModelica is an open-source Modelica-based modeling and simulation environment";
    homepage    = "https://openmodelica.org";
    license     = licenses.gpl3;
    maintainers = with maintainers; [ ];
    platforms   = platforms.linux;
  };
}
