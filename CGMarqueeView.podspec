Pod::Spec.new do |s|

  s.name         = "CGMarqueeView"
  s.version      = "1.0.0"
  s.summary      = "CGMarqueeView"
  s.description  = "my first cocoapods library"
  s.homepage     = "https://github.com/cgpu456/CGMarqueeView"
  s.license      = "MIT"
  s.author       = { "cgpu456" => "chenp1213@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/cgpu456/CGMarqueeView.git", :tag => "#{s.version}" }
  s.requires_arc = true

  s.source_files = "CGMarqueeView/*"
  s.frameworks = "Foundation","CoreGraphics","UIKit"

end