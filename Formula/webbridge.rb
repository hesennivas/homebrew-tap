class Webbridge < Formula
  desc "Native macOS cockpit for Android & iOS webview debugging"
  homepage "https://github.com/hesennivas/webbridge"
  url "https://github.com/hesennivas/webbridge/archive/refs/tags/v0.0.1.tar.gz"
  sha256 "c044c37452e8b145ca056ba6de5b7f16c8d3f37d3f390ccf21b3061854f28b59"
  license "MIT"

  depends_on "android-platform-tools"
  depends_on "ios-webkit-debug-proxy"
  depends_on xcode: ["26.0", :build]
  depends_on macos: :tahoe

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"

    app = libexec/"WebBridge.app"
    (app/"Contents/MacOS").mkpath
    (app/"Contents/Resources").mkpath
    (app/"Contents/MacOS").install ".build/release/WebBridge"
    (app/"Contents").install "Sources/WebBridge/Info.plist"
    (app/"Contents/Resources").install "icon/AppIcon.icns"

    bin.write_exec_script app/"Contents/MacOS/WebBridge"
  end

  test do
    assert_predicate libexec/"WebBridge.app/Contents/MacOS/WebBridge", :exist?
  end
end
