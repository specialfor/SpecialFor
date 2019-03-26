Pod::Spec.new do |s|
  s.name             = 'SpecialFor'
  s.version          = '0.1.0'
  s.summary          = 'A short description of SpecialFor.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Volodymyr Hryhoriev/SpecialFor'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Volodymyr Hryhoriev' => 'volodja.grigoriev@gmail.com' }
  s.source           = { :git => 'https://github.com/Volodymyr Hryhoriev/SpecialFor.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/specialfor_ios'

  s.ios.deployment_target = '10.0'
  s.swift_version = '4.2'
  
  # s.resource_bundles = {
  #   'SpecialFor' => ['SpecialFor/Assets/*.png']
  # }

  # s.frameworks = 'UIKit', 'MapKit'
  
  s.source_files = 'Specialfor/Classes/**/*'
  s.dependency 'SnapKit'
  
  s.default_subspec = 'Core'

  s.subspec 'Core' do |core|
      core.source_files = 'Specialfor/Classes/Core/**/*'
  end
  
  s.subspec 'UIKit' do |ui_kit|
      ui_kit.frameworks = 'UIKit'
      ui_kit.source_files = 'Specialfor/Classes/UIKit/**/*'
  end
  
  s.subspec 'AVFoundation' do |av_foundation|
      av_foundation.frameworks = 'AVFoundation'
      av_foundation.source_files = 'Specialfor/Classes/Extensions/AVFoundation/*'
  end
end
