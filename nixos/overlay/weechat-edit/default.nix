{ stdenv, lib, fetchurl, substituteAll }:

stdenv.mkDerivation {
  pname = "edit";
  version = "c1f6966d32f8c54a480fa60b20eb9e82c4a16a33";

  src = fetchurl {
    url = "https://raw.githubusercontent.com/keith/edit-weechat/f5a8ab1e8345a8b13d7c13445968b66addbbe1bb/edit.py";
    sha256 = "sha256-BDuVNV6ODCPrM6ti/lK7HrBPuoZA7QTC3b/zrwJ/g5w=";
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

