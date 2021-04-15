{ pkgs, stdenv }:

with stdenv.lib;
with (import <mynixpkgs> {});

stdenv.mkDerivation rec {
  name = "corebird-${version}";
  version = "1.2.2";

  src = fetchFromGitHub {
    owner = "baedert";
    repo = "corebird";
    rev = "f817a7802d45682b3578202dfe5ecec01d44f987";
    sha256 = "08jwihq7icfxw625iya991c1dramkxix3x4fbhxql1cdq0wggivq";
  };

  buildInputs = [
    autoconf automake libtool pkgconfig glib gtk3 gnome3.libgee json_glib
    vala_0_28 hicolor_icon_theme gnome3.rest gnome3.defaultIconTheme sqlite
    libsoup intltool gst_all_1.gstreamer gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base gst_all_1.gst-plugins-good gst_all_1.gst-libav
    gsettings_desktop_schemas makeWrapper
  ];

  preConfigure = ''
  ./autogen.sh
  '';

  preFixup=''
    wrapProgram "$out/bin/corebird" \
      --prefix GIO_EXTRA_MODULES : "${glib_networking}/lib/gio/modules" \
      --set GDK_PIXBUF_MODULE_FILE "$GDK_PIXBUF_MODULE_FILE" \
      --prefix XDG_DATA_DIRS : "$out/share:$XDG_ICON_DIRS:$GSETTINGS_SCHEMAS_PATH"
  '';

  meta = {
      description = ''
        Native Gtk+ Twitter client for the Linux desktop
      '';
      homepage = http://corebird.baedert.org/;
      license = stdenv.lib.licenses.gpl3;
      platforms = with stdenv.lib.platforms; all;
  };
}
