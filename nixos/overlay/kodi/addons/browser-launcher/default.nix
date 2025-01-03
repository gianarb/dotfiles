{ lib, rel, buildKodiAddon, addonUpdateScript, fetchFromGitHub }:

buildKodiAddon rec {
  pname = "browser-launcher";
  namespace = "plugin.program.browser.launcher";
  version = "1.2.6";

  src = fetchFromGitHub {
    owner = "Sandmann79";
    repo = "xbmc";
    rev = "ef3dad0";
    hash = "sha256-FUITcv/bIJs0fPtAbXby7rHaA7HboaIymGMzJ83WKFc=";
  };
  passthru = {
    pythonPath = "./plugin.program.browser.launcher";
    updateScript = addonUpdateScript {
      attrPath = "plugin.program.browser.launcher";
    };
  };
  meta = with lib; {
    homepage = "https://github.com/Sandmann79/xbmc";
    description = "Launch websites via selected Browser in Kiosk-mode";
    platforms = platforms.all;
    license = licenses.gpl2Only;
    maintainers = teams.kodi.members;
  };
}
