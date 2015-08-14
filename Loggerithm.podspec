Pod::Spec.new do |s|
  s.name             = "Loggerithm"
  s.version          = "1.2"
  s.summary          = "A lightweight Swift logger."
  s.description      = <<-DESC
                       Loggerithm - A lightweight Swift logger, uses `println` in Debug and `NSLog` in Production with colourful output.

                       Features
                       * Use `println` in Debug and `NSLog` in Production.
                       * Formatted Output, just like `NSLog`.
                       * Log Level Support.
                       * Colorful Output and Color Customization.
                       * Comprehensive Unit Test Coverage.

                       DESC
  s.homepage         = "https://github.com/honghaoz/Loggerithm"
  s.screenshots      = "https://raw.githubusercontent.com/honghaoz/Loggerithm/master/Assets/demo.png"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Honghao Zhang" => "zhh358@gmail.com" }
  s.source           = { :git => "https://github.com/honghaoz/Loggerithm.git", :tag => s.version.to_s }
  s.social_media_url = 'https://www.linkedin.com/in/honghaozhang'

  # s.platform = :ios, "8.0"
  # s.platform = :osx, "10.9"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.requires_arc     = true

  s.xcconfig         = { 'OTHER_SWIFT_FLAGS' => '-D DEBUG' }
  s.source_files     = 'Source/*.swift'
  s.ios.frameworks   = 'UIKit'
  s.osx.frameworks   = 'Cocoa'

end
