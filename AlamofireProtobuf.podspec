Pod::Spec.new do |s|
  s.name         = "AlamofireProtobuf"
  s.version      = "1.0.0"
  s.summary      = "AlamofireProtobuf is a protobuf component library for Alamofire"
  s.homepage     = "http://alamofireprotobuf.yep.io"
  s.license      = "Apache 2.0"
  s.authors = { 'www.moyep.me' => 'heisonyee@126.com' }
  s.source = {:git => 'https://github.com/heisonyee/AlamofireProtobuf.git'}
  s.ios.deployment_target = '9.1'

  s.module_name = 'AlamofireProtobuf'
  s.source_files = 'Source/*.{swift}'
  s.requires_arc = true
  s.frameworks   = 'Foundation'

  s.dependency 'Alamofire', '~> 4.2.0'
  s.dependency 'Protobuf', '~> 3.1.0'
end
