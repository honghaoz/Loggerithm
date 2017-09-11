Pod::Spec.new do |s|
  s.name             = "Loggerithm"
  s.version          = "1.5.0"
  s.summary          = "A lightweight Swift logger."
  s.description      = <<-DESC
                       Loggerithm - A lightweight Swift logger, uses `print` in Debug and `NSLog` in Production with colourful output.

                       Features
                       * Use `print` in Debug and `NSLog` in Production.
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

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"

  s.requires_arc     = true

  s.source_files     = 'Source/*.swift'
  s.ios.frameworks   = 'UIKit'
  s.osx.frameworks   = 'Cocoa'

  # s.xcconfig         = { 'OTHER_SWIFT_FLAGS[config=Debug]' => '-D DEBUG' }
end
