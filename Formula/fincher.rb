class Fincher < Formula
  desc "Steganography tool for text"
  homepage "https://github.com/maxfierke/fincher"
  url "https://github.com/maxfierke/fincher/archive/0.1.1.tar.gz"
  sha256 "c29be72f7b1eeefb1aad9425a42e159cfef908d96d6f624dfdfa2f074fb2c471"

  bottle do
    root_url "https://github.com/maxfierke/fincher/releases/download/0.1.1"
    sha256 cellar: :any, catalina: "7ea8c633e58ccb9b2b091bb2be383dc3f04c78387e385f8952d31e14c7b7c652"
  end

  depends_on "crystal" => :build
  depends_on "libevent"
  depends_on "libyaml"

  def install
    system "make", "install", "PREFIX=#{prefix}", "RELEASE=1"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test fincher`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{bin}/fincher", "encode"
  end
end
