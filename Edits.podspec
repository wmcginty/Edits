#
# Be sure to run `pod lib lint Edits.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Edits'
  s.version          = '0.1.0'
  s.summary          = 'A micro-framework to determine and display the smallest set of edits between two collections.'

  s.description      = <<-DESC
Edits is a small framework designed to simplify the process of creating visually pleasing transitions between collections. Specially designed with UITableView and UICollectionView in mind, Edits will make it incredibly easy to create attractive transitions between collections.
                       DESC

  s.homepage         = 'https://github.com/wmcginty/Edits'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'William McGinty' => 'mcgintw@gmail.com' }
  s.source           = { :git => 'https://github.com/wmcginty/Edits.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'Sources/**/*'
  s.frameworks = 'UIKit'
end
