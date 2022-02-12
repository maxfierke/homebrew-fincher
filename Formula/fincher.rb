class Fincher < Formula
  desc "Steganography tool for text"
  homepage "https://github.com/maxfierke/fincher"
  url "https://github.com/maxfierke/fincher/archive/0.2.0.tar.gz"
  sha256 "e4aa58b688b4c63281a0cddaef8e6febcb3cf089f0e5516dcd943b7a8483bf18"

  bottle do
    root_url "https://github.com/maxfierke/fincher/releases/download/0.1.1"
    sha256 cellar: :any, catalina: "7ea8c633e58ccb9b2b091bb2be383dc3f04c78387e385f8952d31e14c7b7c652"
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
    system "#{bin}/fincher", "encode"

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
