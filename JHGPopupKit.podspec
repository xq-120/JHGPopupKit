Pod::Spec.new do |spec|

  spec.name         = "JHGPopupKit"
  spec.version      = "1.8.0"
  spec.summary      = "弹窗."
  spec.description  = <<-DESC
                    一个自定义程度非常高的弹窗组件。它对外提供一个容器视图，因此开发者可以完全自定义弹窗内容。
                    同时封装了弹窗的显示与隐藏，并提供了两种默认的动画效果，开发者可实现自己的动画效果。
                    DESC
  spec.homepage     = "https://github.com/xq-120/JHGPopupKit"
  spec.license      = "MIT"
  spec.author       = { "uzzi" => "1204556447@qq.com" }
  
  spec.platform     = :ios, "10.0"
  spec.source       = { :git => "https://github.com/xq-120/JHGPopupKit.git", :tag => "#{spec.version}" }
  
  spec.subspec 'Core' do |ss|
    ss.source_files = 'JHGPopupKit/Core/*.{h,m}'
  end
  
  spec.subspec 'PopupView' do |ss|
    ss.source_files = 'JHGPopupKit/PopupView/*.{h,m}'
    ss.dependency 'JHGPopupKit/Core'
  end
  
  spec.subspec 'PopupViewController' do |ss|
    ss.source_files = 'JHGPopupKit/PopupViewController/*.{h,m}'
    ss.dependency 'JHGPopupKit/Core'
  end
  
  spec.subspec 'Plugins' do |ss|
    ss.source_files = 'JHGPopupKit/Plugins/*.{h,m}'
    ss.dependency 'JHGPopupKit/PopupView'
  end
  
  spec.subspec 'Utils' do |ss|
    ss.source_files = 'JHGPopupKit/Utils/*.{h,m}'
  end
    
  spec.frameworks   = "Foundation", "UIKit"
  spec.requires_arc = true
  spec.dependency "Masonry", '~> 1.1.0'

  spec.pod_target_xcconfig = {
    'IPHONEOS_DEPLOYMENT_TARGET' => '10.0'
  }
end
