class Fincher < Formula
  desc "Steganography tool for text"
  homepage "https://github.com/maxfierke/fincher"
  url "https://github.com/maxfierke/fincher/archive/0.2.1.tar.gz"
  sha256 "4eb490f72b576ac96eeef6a85235773df272c39cd5d44ab52172bab6f4be0756"

  bottle do
    root_url "https://github.com/maxfierke/homebrew-fincher/releases/download/fincher-0.2.0"
    rebuild 1
    sha256 cellar: :any,                 big_sur:      "3f18b02339438283f1308a0d4cd2901e3fc1b229cc68a98632a1f6eae346f6c1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "70e003512acdfc624fccc11f641854e2783bbf04e3e7a217815f371d28339e2d"
  end

  depends_on "crystal" => :build
  depends_on "bdw-gc"
  depends_on "libevent"
  depends_on "libyaml"
  depends_on "pcre"
  depends_on "zlib"

  def install
    system "make", "install", "PREFIX=#{prefix}", "RELEASE=1"
  end

  test do
    src_text = "There are few places with more iconic rock structures than " \
               "the American Southwest with the red rocks and glacier-formed " \
               "peaks. I made this up. Who knows. However, there is maybe some " \
               "truth to it and perhaps I am just trying to fill some space for " \
               "a test. I promise this is not intentional disinformation."
    expected = "There are yew places with (ore iconic rock ktructures than " \
               "the #merican Southwest with Hhe red rocks End glacier-formed " \
               "peaks. D made this qp. Who knows. However, there is maybe some " \
               "truth to it and perhaps I am just trying to fill some space for " \
               "a test. I promise this is not intentional disinformation."

    assert_match expected,
      shell_output("echo '#{src_text}' | \
        #{bin}/fincher encode \
        --word-offset 2 \
        --displacement-strategy word-offset \
        --seed 4095185266 \
        homebrew")
  end
end
