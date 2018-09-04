Pod::Spec.new do |s|
  s.name             = 'Vite-keystore'
  s.version          = '0.0.1'
  s.summary          = 'vite 密钥库'
  s.homepage         = 'https://github.com/vitelabs/vite-keystore-ios'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Water' => 'caoliang@vite.org' }
  s.source           = { :git => 'https://github.com/vitelabs/vite-keystore-ios.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'Vite-keystore/Classes/**/*'

  s.frameworks = 'UIKit', 'Security'
  s.dependency 'BigInt', '~> 3.0'
  s.dependency 'secp256k1.swift', '~> 0.1.4'
  s.dependency 'CryptoSwift', '~> 0.11'
  s.dependency 'scrypt', '~> 1.5'
  s.dependency 'libEd25519Blake2b'

  s.pod_target_xcconfig = { 'SWIFT_OPTIMIZATION_LEVEL' => '-Owholemodule' }
end
