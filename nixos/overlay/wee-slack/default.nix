{ stdenv, lib, fetchFromGitHub, python3, python3Packages, perl }:

let
  websocketClientPath = "${python3Packages.websocket-client}/${python3.sitePackages}";
in
stdenv.mkDerivation {
  pname = "wee-slack";
  version = "3.0.0-unstable-2026-03-25";

  src = fetchFromGitHub {
    owner = "wee-slack";
    repo = "wee-slack";
    rev = "d0ec90423317aabd08bc4d5fec0b13b118c265f4";
    hash = "sha256-LetX5/qdDyFW/amqcNlVLKf3iRAsrd4oS5kA8JQvlgw=";
  };

  nativeBuildInputs = [ perl ];

  buildPhase = ''
    runHook preBuild
    bash build.sh
    # Inject websocket-client path before the websocket import so weechat can find it at runtime
    sed -i "s|^from websocket |import sys\nsys.path.insert(0, '${websocketClientPath}')\nfrom websocket |" build/slack.py
    # Weechat doesn't run scripts as __main__, so call register() unconditionally
    perl -i -0pe 's/if __name__ == "__main__":\n    register\(\)/register()/' build/slack.py
    runHook postBuild
  '';

  passthru.scripts = [ "slack.py" ];

  installPhase = ''
    runHook preInstall
    install -D build/slack.py $out/share/slack.py
    runHook postInstall
  '';

  meta = with lib; {
    description = "A WeeChat plugin for Slack";
    homepage = "https://github.com/wee-slack/wee-slack";
    license = licenses.mit;
  };
}
