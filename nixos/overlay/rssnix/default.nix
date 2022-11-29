{ fetchFromGitHub, buildGo118Module }:

buildGo118Module {
  pname = "rssnix";
  version = "b2e21359973d98a54c10ac570d8d85c269189272";
  vendorSha256 = "sha256-tcRk0J+Mllf5J6MjLdm2ODm+ePepN3cB5GKaGC2I/i0=";
  src = fetchFromGitHub {
    owner = "jafarlihi";
    repo = "rssnix";
    rev = "b2e21359973d98a54c10ac570d8d85c269189272";
    sha256 = "sha256-/qpqxFC1EJr233jj65gwDkDa+WCczZwAMsl1KJMDPas=";
  };
}
