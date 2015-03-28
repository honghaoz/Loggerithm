Pod::Spec.new do |s|
  s.name             = "ZHSwiftLogger"
  s.version          = "0.9"
  s.summary          = "A simple log utility for Swift project"
  s.description      = "Provide fast log for debugging as well as log for production. (Used `println()` in development and `NSLog()` in production)"
  s.homepage         = "https://github.com/honghaoz/ZHSwiftLogger"
  s.screenshots      = "https://raw.githubusercontent.com/honghaoz/ZHSwiftLogger/master/Preview/Pre.png"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Honghao Zhang" => "zhh358@gmail.com" }
  s.source           = { :git => "https://github.com/honghaoz/ZHSwiftLogger.git", :tag => "0.9" }
  s.social_media_url = 'https://www.linkedin.com/in/honghaozhang'

  s.platform         = :ios, '8.0'
  s.requires_arc     = true

  s.source_files = 'ZHLogger.swift'
  # s.resource_bundles = {
  #   'ZHSwiftLogger' => ['Pod/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
