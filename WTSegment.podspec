Pod::Spec.new do |s|
  s.name         = "WTSegment"
  s.version      = "0.3.2"
  s.summary      = "GUOTAIJUNAN YDPT Lib"
  s.description  = "GJYD components...GUOTAIJUNAN YDPT Lib"
  s.homepage     = "http://www.wutongr.com"
  s.license      = 'MIT'
  s.author       = { "wutongr" => "zc_and_zc@aliyun.com" }
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/wutongr/WTSegment.git", :tag => s.version }
  s.requires_arc = true
  s.source_files = 'WTSegment/WTSegment/{WTSegment}*.{h,m}'
  s.frameworks   = 'QuartzCore'

end
