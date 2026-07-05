class Webbridge < Formula
  desc "Native macOS cockpit for Android & iOS webview debugging"
  homepage "https://github.com/hesennivas/webbridge"
  url "https://github.com/hesennivas/webbridge/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "REPLACE_WITH_ACTUAL_SHA256"
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
