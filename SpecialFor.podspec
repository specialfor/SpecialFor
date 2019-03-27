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
  
  s.source_files = 'Specialfor/Classes/**/*'
  
  #s.default_subspec = 'Core'

  s.subspec 'Core' do |core|
      core.source_files = 'Specialfor/Classes/Core/**/*'
  end
  
  s.subspec 'UIKit' do |ui_kit|
      ui_kit.frameworks = 'UIKit'
      ui_kit.source_files = 'Specialfor/Classes/UIKit/**/*'
      ui_kit.dependency 'SnapKit'
      
      ui_kit.subspec 'PartialCheckableButton' do |pcb|
          pcb.dependency 'SpecialFor/UIKit/View'
          pcb.source_files = '**/{PartialCheckableButton,Closure}.swift'
      end
      
      ui_kit.subspec 'View' do |view|
          view.source_files = '**/View.swift'
      end
      
      ui_kit.subspec 'ImageAlertViewController' do |iavc|
          iavc.source_files = '**/{ImageAlertViewController,Closure,UIView+Corners,GCD}.swift'
      end
      
      ui_kit.subspec 'AlignableLabel' do |a_label|
          a_label.source_files = '**/AlignableLabel.swift'
      end
      
      ui_kit.subspec 'Accessories' do |accessories|
          accessories.dependency 'SpecialFor/UIKit/Gradient'
          accessories.dependency 'SpecialFor/UIKit/SeparatorView'
      end
      
      ui_kit.subspec 'Gradient' do |gradient|
          gradient.source_files = '**/Gradient/**/*'
      end
      
      ui_kit.subspec 'SeparatorView' do |s_view|
          s_view.dependency 'SpecialFor/UIKit/View'
          s_view.source_files = '**/SeparatorView.swift'
      end
      
      ui_kit.subspec 'EmptyStateTableViewDS' do |estvds|
          estvds.dependency 'SpecialFor/UIKit/View'
          estvds.source_files = '**/EmptyState/**/*', '**/{TableViewDataSourceProxy,Closure,UIView+Toggle}.swift'
      end
  end
  
  s.subspec 'AVFoundation' do |av_foundation|
      av_foundation.frameworks = 'AVFoundation'
      av_foundation.source_files = 'Specialfor/Classes/AVFoundation/*'
  end
  
  s.subspec 'Photos' do |photos|
      photos.frameworks = 'Photos'
      photos.source_files = 'Specialfor/Classes/Photos/*'
  end
end
