{ stdenv, lib, fetchurl, substituteAll }:

stdenv.mkDerivation {
  pname = "edit";
  version = "c1f6966d32f8c54a480fa60b20eb9e82c4a16a33";

  src = fetchurl {
    url = "https://raw.githubusercontent.com/keith/edit-weechat/c1f6966d32f8c54a480fa60b20eb9e82c4a16a33/edit.py";
    sha256 = "03snznglqfdmalj828xpj62k87lcw0905ybbyxzpa0qr5sdlilfh";
  };

  dontUnpack = true;
  prePatch = ''
    cp $src edit.py
  '';

  passthru.scripts = [ "edit.py" ];

  installPhase = ''
    runHook preInstall
    install -D edit.py $out/share/edit.py
    runHook postInstall
  '';

  meta = with lib; {
    description = "Compose weechat messages in your $EDITOR";
    license = licenses.mit;
  };
}

