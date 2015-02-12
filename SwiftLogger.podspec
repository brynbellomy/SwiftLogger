

Pod::Spec.new do |s|
  s.name = 'SwiftLogger'
  s.version = '0.0.1'
  s.license = 'WTFPL'
  s.summary = 'Logging.  In Swift.'
  s.authors = { 'bryn austin bellomy' => 'bryn.bellomy@gmail.com' }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.source_files = 'SwiftLogger/*.swift'

  s.dependency 'FlatUIColors'
  s.dependency 'Starscream', '0.9.2'
  s.dependency 'Funky', '0.1.2'

  s.homepage = 'https://github.com/brynbellomy/SwiftLogger'
  s.source = { :git => 'https://github.com/brynbellomy/SwiftLogger.git', :tag => s.version }
end
