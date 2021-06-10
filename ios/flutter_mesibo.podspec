#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_mesibo.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_mesibo'
  s.version          = '0.0.1'
  s.summary          = 'Flutter plugin to use the Mesibo real-time chat API on Android and iOS.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'https://github.com/fxjordan/flutter_mesibo'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Felix Jordan' => 'felix.jordan@buddy-app.de' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  # Mesibo has transitive static framework dependency, so we need to be static too
  s.static_framework = true
  s.dependency 'Flutter'
  # TODO Update mesibo dependecy from time to time
  s.dependency 'mesibo', '~>1.4.5'
  s.platform = :ios, '10.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
