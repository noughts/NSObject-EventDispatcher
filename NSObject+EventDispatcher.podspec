Pod::Spec.new do |s|
  s.name         = "NSObject+EventDispatcher"
  s.version      = "0.1.0"
  s.summary      = "Event Dispatcher"
  s.homepage     = "https://github.com/noughts/NSObject-EventDispatcher"
  s.author       = { "noughts" => "noughts@gmail.com" }
  s.source       = { :git => "https://github.com/noughts/NSObject-EventDispatcher.git", :tag => "0.2.0" }
  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.platform = :ios
  s.requires_arc = true
  s.source_files = 'NSObject+EventDispatcher'
end
