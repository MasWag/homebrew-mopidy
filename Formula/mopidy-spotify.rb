class MopidySpotify < Formula
  include Language::Python::Virtualenv

  desc "Mopidy extension for playing music from Spotify"
  homepage "https://github.com/mopidy/mopidy-spotify"
  url "https://files.pythonhosted.org/packages/dc/9c/abd89195770fa8a7b7835f23b41657a0eddf13b58512a916da2dfd126d92/Mopidy-Spotify-4.1.1.tar.gz"
  sha256 "e137d0675288e48563c15d50cb2722c618f1a085673f96b620e64fafdaab97af"
  head "https://github.com/mopidy/mopidy-spotify.git", branch: "main"
  revision 1

  depends_on "python@3.12"
  depends_on "mopidy/mopidy/mopidy"

  # Dependencies required by pyproject.toml
  resource "pykka" do
    url "https://files.pythonhosted.org/packages/7d/90/cf6b964a454e8dbc4365f4f438d6e82aae9b6a313fd547f5bac635b74f8b/pykka-4.2.0.tar.gz"
    sha256 "68d7b923def1b6464bbc214aa56453f00bab31c66b459803ece0c49ee43f22eb"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/9d/be/10918a2eac4ae9f02f6cfe6414b7a155ccd8f7f9d4380d62fd5b955065c3/requests-2.31.0.tar.gz"
    sha256 "942c5a758f98d790eaed1a29cb6eefc7ffb0d1cf7af05c3d2791656dbd6ad1e1"
  end

  def install
    virtualenv_install_with_resources
    python3 = Formula["python@3.12"].opt_bin/"python3.12"

    xy = Language::Python.major_minor_version python3
    site_packages = "lib/python#{xy}/site-packages"
    pth_contents = "import site; site.addsitedir('#{libexec/site_packages}')\n"
    (prefix/site_packages/"homebrew-mopidy-spotify.pth").write pth_contents
  end

  test do
    python3 = Formula["python@3.12"].opt_bin/"python3.12"
    system python3, "-c", "import mopidy_spotify"
  end
end
