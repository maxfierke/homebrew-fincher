class Fincher < Formula
  desc "Steganography tool for text"
  homepage "https://github.com/maxfierke/fincher"
  url "https://github.com/maxfierke/fincher/archive/0.3.0.tar.gz"
  sha256 "89481ad614e137554d59608e8a6cc97148afaaa49aec29b9d2b9c5202832bdaf"

  bottle do
    root_url "https://github.com/maxfierke/homebrew-fincher/releases/download/fincher-0.2.1"
    sha256 cellar: :any,                 monterey:     "b0752cde5110120d67ee393bd313ca1590aa954b3767131bc5a46142c4b26a72"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "92737f42fbff311f9bc7508d724ba2f8711a950baa74b9010dec99206493326a"
  end

  depends_on "crystal" => :build
  depends_on "bdw-gc"
  depends_on "libyaml"
  depends_on "pcre2"
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
