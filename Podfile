
post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0' #9.0
         end
    end
  end
end


source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'
# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'
#source 'https://github.com/CocoaPods/Specs.git'
target 'metar' do
  use_frameworks!
  pod 'AFNetworking'
  pod 'SDWebImage'
  pod 'IQKeyboardManager'
  pod 'MJRefresh'
  pod 'MJExtension'
  pod 'Masonry'
  pod 'MBProgressHUD'
  pod 'UITextView+Placeholder'
  pod 'QMUIKit'
  pod 'YYImage' #展示gif图片
  pod 'YYText'
  pod 'SnapKit'
end
