# Uncomment the next line to define a global platform for your project
 platform :ios, '13.0'

target 'ChatApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ChatApp
  pod 'Firebase/Auth', '~> 8.1.0'
  #pod 'Firebase/Firestore'
  #pod 'IQKeyboardManagerSwift'
  
  post_install do |installer|
   installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
     config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
    end
   end
  end

end