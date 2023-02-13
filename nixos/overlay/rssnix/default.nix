{ fetchFromGitHub, buildGo118Module }:

buildGo118Module {
  pname = "rssnix";
  version = "1e756cc42acb3748f20f270fc0a0e47d29a14622";
  vendorSha256 = "sha256-QMEubCu1zpH9xb6qwtzf+hE806/9c9beMzfCv8K/yCQ=";
  src = fetchFromGitHub {
    owner = "jafarlihi";
    repo = "rssnix";
    rev = "1e756cc42acb3748f20f270fc0a0e47d29a14622";
    sha256 = "sha256-ftY535Qkyj+SAL7a/v+BK9cTTIO28vbynSjsRYP88b0=";
  };
}
