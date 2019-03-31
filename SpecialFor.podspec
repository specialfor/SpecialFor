Pod::Spec.new do |s|
  s.name             = 'SpecialFor'
  s.version          = '0.1.0'
  s.summary          = 'Useful codebase which I used among projects'

  s.homepage         = 'https://github.com/specialfor/SpecialFor'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Volodymyr Hryhoriev' => 'volodja.grigoriev@gmail.com' }
  s.source           = { :git => 'https://github.com/specialfor/SpecialFor.git', :tag => s.version.to_s }
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
      ui_kit.dependency 'SnapKit', '= 4.2.0'
      
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
      
      ui_kit.subspec 'FastScroll' do |fast_scroll|
          fast_scroll.dependency 'SpecialFor/UIKit/View'
          fast_scroll.source_files = '**/FastScroll/**/*', '**/{Closure,UIView+Corners}.swift'
      end
      
      ui_kit.subspec 'TextField' do |text_field|
          text_field.source_files = '**/TextField.swift'
      end
      
      ui_kit.subspec 'ImagePlaceholderTextField' do |ip_text_field|
          ip_text_field.dependency 'SpecialFor/UIKit/TextField'
          ip_text_field.dependency 'SpecialFor/UIKit/View'
          ip_text_field.source_files = '**/{ImagePlaceholderTextField,Closure}.swift'
      end
      
      ui_kit.subspec 'MaterialTextInput' do |mti|
          mti.dependency 'SpecialFor/UIKit/TextField'
          mti.dependency 'SpecialFor/UIKit/View'
          mti.source_files = '**/Material/**/*', '**/Closure.swift'
      end
      
      ui_kit.subspec 'LinkTextField' do |link_text_field|
          link_text_field.dependency 'SpecialFor/UIKit/MaterialTextInput'
          link_text_field.source_files = '**/LinkTextField/**/*', '**/{Closure,String+Contains}.swift'
      end
      
      ui_kit.subspec 'ImagesView' do |images_view|
          images_view.dependency 'SpecialFor/UIKit/View'
          images_view.source_files = '**/ImagesView/**/*', '**/UIImageView+Corners.swift'
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
