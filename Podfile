# Uncomment this line to define a global platform for your project
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'

target 'swift-github-repo-search-lab' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for swift-github-repo-search-lab
  pod 'Alamofire', '~> 4.0'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
