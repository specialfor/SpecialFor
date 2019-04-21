Pod::Spec.new do |s|
  s.name             = 'SpecialFor'
  s.version          = '0.4.0'
  s.summary          = 'Useful codebase which I used among projects'

  s.homepage         = 'https://github.com/specialfor/SpecialFor'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Volodymyr Hryhoriev' => 'volodja.grigoriev@gmail.com' }
  s.source           = { :git => 'https://github.com/specialfor/SpecialFor.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/specialfor_ios'

  s.ios.deployment_target = '10.0'
  s.swift_version = '4.2'
  
  s.source_files = 'Specialfor/Classes/**/*'
  
  # Variables
  
  snap_kit_version = '= 4.2.0'
  
  
  # Subspecs

  s.subspec 'Core' do |core|
      core.source_files = 'Specialfor/Classes/Core/**/*'
      
      core.subspec 'Closure' do |closure|
          closure.source_files = '**/Closure.swift'
      end
      
      core.subspec 'GCD' do |gcd|
          gcd.dependency 'SpecialFor/Core/Closure'
          gcd.source_files = '**/GCD.swift'
      end
      
      core.subspec 'Result' do |result|
          result.dependency 'SpecialFor/Core/Closure'
          result.source_files = '**/Result/*'
      end
  end
  
  s.subspec 'AppEnvironment' do |app_env|
      app_env.source_files = '**/AppEnvironment/**/*'
  end
  
  s.subspec 'DataDriven' do |data_driven|
      data_driven.dependency 'SpecialFor/UIKit/Renderable'
      data_driven.dependency 'SpecialFor/UIKit/Setupable'
      data_driven.dependency 'SnapKit', snap_kit_version
      
      data_driven.source_files = '**/DataDriven/**/*', '**/UIWindow+SafeArea.swift'
  end
  
  s.subspec 'UIKit' do |ui_kit|
      ui_kit.frameworks = 'UIKit'
      ui_kit.source_files = 'Specialfor/Classes/UIKit/**/*'
      
      ui_kit.subspec 'PartialCheckableButton' do |pcb|
          pcb.dependency 'SpecialFor/UIKit/View'
          pcb.dependency 'SnapKit', snap_kit_version
          
          pcb.source_files = '**/{PartialCheckableButton,Closure}.swift'
      end
      
      ui_kit.subspec 'View' do |view|
          view.dependency 'SpecialFor/UIKit/Setupable'
          view.source_files = '**/View.swift'
      end
      
      ui_kit.subspec 'ImageAlertViewController' do |iavc|
          iavc.dependency 'SpecialFor/UIKit/Setupable'
          iavc.dependency 'SnapKit', snap_kit_version
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
          s_view.dependency 'SnapKit', snap_kit_version
          
          s_view.source_files = '**/SeparatorView.swift'
      end
      
      ui_kit.subspec 'EmptyStateTableViewDS' do |estvds|
          estvds.dependency 'SpecialFor/UIKit/View'
          estvds.dependency 'SnapKit', snap_kit_version
          
          estvds.source_files = '**/EmptyState/**/*', '**/{TableViewDataSourceProxy,Closure,UIView+Toggle}.swift'
      end
      
      ui_kit.subspec 'FastScroll' do |fast_scroll|
          fast_scroll.dependency 'SpecialFor/UIKit/View'
          fast_scroll.dependency 'SnapKit', snap_kit_version
          
          fast_scroll.source_files = '**/FastScroll/**/*', '**/{Closure,UIView+Corners}.swift'
      end
      
      ui_kit.subspec 'TextField' do |text_field|
          text_field.dependency 'SpecialFor/Core/Closure'
          text_field.source_files = '**/TextField.swift'
      end
      
      ui_kit.subspec 'ImagePlaceholderTextField' do |ip_text_field|
          ip_text_field.dependency 'SpecialFor/UIKit/TextField'
          ip_text_field.dependency 'SpecialFor/UIKit/View'
          ip_text_field.dependency 'SnapKit', snap_kit_version
          
          ip_text_field.source_files = '**/{ImagePlaceholderTextField,Closure}.swift'
          ip_text_field.resources = '**/ImagePlaceholderTextField.xcassets'
      end
      
      ui_kit.subspec 'MaterialTextInput' do |mti|
          mti.dependency 'SpecialFor/UIKit/TextField'
          mti.dependency 'SpecialFor/UIKit/View'
          mti.dependency 'SnapKit', snap_kit_version
          
          mti.source_files = '**/Material/**/*', '**/Closure.swift'
      end
      
      ui_kit.subspec 'LinkTextField' do |link_text_field|
          link_text_field.dependency 'SpecialFor/UIKit/MaterialTextInput'

          link_text_field.source_files = '**/LinkTextField/**/*', '**/{Closure,String+Contains}.swift'
          link_text_field.resources = '**/LinkTextField.xcassets'
      end
      
      ui_kit.subspec 'ImagesView' do |images_view|
          images_view.dependency 'SpecialFor/UIKit/View'
          images_view.dependency 'SnapKit', snap_kit_version
          images_view.dependency 'Kingfisher', '=5.3.1'
          
          images_view.source_files = '**/ImagesView/**/*', '**/UIImageView+Corners.swift'
          images_view.resources = '**/ImagesView.xcassets'
      end
      
      ui_kit.subspec 'BannerWindow' do |bannew_window|
          bannew_window.dependency 'SnapKit', snap_kit_version
          bannew_window.source_files = '**/BannerWindow.swift'
      end
      
      ui_kit.subspec 'GifLoaderView' do |gif_l_view|
          gif_l_view.dependency 'SnapKit', snap_kit_version
          gif_l_view.dependency 'SwiftGifOrigin', '= 1.7.0'
          gif_l_view.dependency 'SpecialFor/UIKit/View'
          gif_l_view.dependency 'SpecialFor/UIKit/Renderable'
          
          gif_l_view.source_files = '**/GifLoaderView.swift'
      end
      
      ui_kit.subspec 'Renderable' do |renderable|
          renderable.source_files = '**/Renderable.swift'
      end
      
      ui_kit.subspec 'Setupable' do |setupable|
          setupable.source_files = '**/Setupable.swift'
      end
      
      ui_kit.subspec 'Loadable' do |loadable|
          loadable.dependency 'SpecialFor/UIKit/Renderable'
          loadable.dependency 'SnapKit', snap_kit_version
          
          loadable.source_files = '**/Loadable.swift'
      end
      
      ui_kit.subspec 'Backable' do |backable|
          backable.source_files = '**/Backable.swift'
          backable.resources = '**/Backable.xcassets'
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
