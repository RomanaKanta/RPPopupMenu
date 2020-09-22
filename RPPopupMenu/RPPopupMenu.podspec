#
#  Be sure to run `pod spec lint RPPopupMenu.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "RPPopupMenu"
  spec.version      = "0.0.1"
  spec.summary      = "A CocoaPods library written in Swift"
 
  spec.description  = <<-DESC
  This CocoaPods library helps you to experience different type of menu.
                   DESC

  spec.homepage     = "https://github.com/Romana-Parvin/RPPopupMenu"
  # spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  spec.author             = { "Romana" => "romanap.dev@gmail.com" }
 
  spec.ios.deployment_target = "10.0"
  spec.swift_version = "5"

  spec.source       = { :git => "https://github.com/Romana-Parvin/RPPopupMenu.git", :tag => "#{spec.version}" }
  spec.source_files  = "RPPopupMenu/**/*.{h,m,swift}"

end
