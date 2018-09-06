#
#  Be sure to run `pod spec lint EGSpinner.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
#1.
s.name               = "EGSpinner"
#2.
s.version            = "1.0.1"
#3.
s.summary         = "Simple spinner button with options"
#4.
s.homepage        = "https://github.com/EGApplications"
#5.
s.license              = "MIT"
#6.
s.author               = "EGApplications"
#7.
s.platform            = :ios, "11.0"
#8.
s.source              = { :git => "https://github.com/EGApplications/EGSpinner.git", :tag => "1.0.1" }
#9.
s.source_files     = "EGSpinner", "EGSpinner/**/*.{h,m,swift}"
end
