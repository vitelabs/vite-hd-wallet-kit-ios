Pod::Spec.new do |s|
  s.name             = 'Vite_HDWalletKit'
  s.version          = '1.1.0'
  s.summary          = 'Vite App HD wallet kit'
  s.homepage         = 'https://github.com/vitelabs/vite-keystore-ios'
  s.description      = <<-DESC
Vite wallet is a swift framework that you  can  create mnemonic words ,bip public key ,address
                       DESC
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Water' => 'caoliang@vite.org' }
  s.source           = { :git => 'https://github.com/vitelabs/vite-keystore-ios.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'Vite-keystore/Classes/**/*'
  s.public_header_files = 'Vite-keystore/Classes/Core/Crypto/Bit.h'

  s.frameworks = 'UIKit', 'Security'
  s.dependency 'BigInt', '~> 3.0'
  s.dependency 'CryptoSwift', '~> 0.12.0'
  s.dependency 'TrezorCryptoEd25519WithBlake2b', '~> 0.0.1'
  s.pod_target_xcconfig = { 'SWIFT_OPTIMIZATION_LEVEL' => '-Owholemodule' }
end
