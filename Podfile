# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'AtTheStadium' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for AtTheStadium
  pod 'Firebase'
  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'Firebase/Storage'
  pod 'FirebaseUI/Storage'
  pod 'SVProgressHUD'
  pod 'CLImageEditor/AllTools'
  pod 'YPImagePicker'
  pod 'UITextView+Placeholder'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
    end
  end
end