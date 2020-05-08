platform :ios, '12.0'

target 'Weather' do

  use_frameworks!

  pod 'R.swift', '~> 5'
  pod 'SwiftLint'

end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end
