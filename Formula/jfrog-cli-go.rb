class JfrogCliGo < Formula
  desc "Command-line interface for Jfrog Artifactory and Bintray"
  homepage "https://github.com/jfrog/jfrog-cli"
  url "https://github.com/JFrog/jfrog-cli-go/archive/1.33.1.tar.gz"
  sha256 "0960f073991dd2e754ee3809f6c371529de90399f2acdfc3c507dbdc9717d1e6"

  bottle do
    cellar :any_skip_relocation
    sha256 "1ed07b2c2ddc31e1fd54993544ab3197217b4ca9babfd3f822eda8f0e76ecbab" => :catalina
    sha256 "86be6259521c9f71bdf652541b469ec5d381e9ae0056eb14f7a754832c9f2bb6" => :mojave
    sha256 "8a6cdad80bfd801e24af8ff854f1e9dd4fdd2e4fc3eb880f9e2ecc606f5453b5" => :high_sierra
  end

  depends_on "go" => :build

  def install
    system "go", "run", "./python/addresources.go"
    system "go", "build", "-ldflags", "-s -w -extldflags '-static'", "-trimpath", "-o", bin/"jfrog"
    prefix.install_metafiles
    system "go", "generate", "./completion/shells/..."
    bash_completion.install "completion/shells/bash/jfrog"
    zsh_completion.install "completion/shells/zsh/jfrog" => "_jfrog"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/jfrog -v")
  end
end
