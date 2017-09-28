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
  s.summary          = 'A mini-framework to determine the smallest set of edits between two collections.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Edits is a small framework designed to simplify the process of creating visually pleasing transitions between collections. Especially designed with UITableView and UICollectionView in mind, Edits will make it incredibly easy to create attractive transitions between collections.
                       DESC

  s.homepage         = 'https://github.com/wmcginty/Edits'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'William McGinty' => 'mcgintw@gmail.com' }
  s.source           = { :git => 'https://github.com/wmcginty/Edits.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.3'

  s.source_files = 'Edits/Classes/**/*'

  # s.resource_bundles = {
  #   'Edits' => ['Edits/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
