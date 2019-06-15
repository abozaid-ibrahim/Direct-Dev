platform :ios, '10.0'
target 'Direct' do
  use_frameworks!

  pod 'PanModal'
#  pod 'Hero'
  pod 'RxSwift',    '~> 4.0'
  pod 'Moya/RxSwift', '~> 13.0'
  pod 'RxOptional'
  pod 'RxCocoa',    '~> 4.0'
  pod 'RxDataSources'
  pod 'SkyFloatingLabelTextField', '~> 3.0'
  pod 'M13Checkbox'
#  pod 'IBAnalyzer'
  pod 'RxGesture', '~> 2.1'
  pod 'YALField'
  pod 'SwifterSwift'
  pod 'ARSLineProgress', '~> 3.1'
  pod 'Kingfisher', '~> 5.0'
  pod 'JBDatePicker'
  pod 'ViewPager-Swift'

  pod 'GenericCellControllers'
  pod 'SnapKit'
  pod 'SwiftMessages'

  	pod 'IQKeyboardManagerSwift' #, '~> 6.1.1'

end
post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings.delete('CODE_SIGNING_ALLOWED')
    config.build_settings.delete('CODE_SIGNING_REQUIRED')
  end
end
