Pod::Spec.new do |s|
  s.name         = "AlamofireProtobuf"
  s.version      = "1.0.0"
  s.summary      = "AlamofireProtobuf is a protobuf component library for Alamofire"
  s.homepage     = "http://alamofireprotobuf.yep.io"
  s.license      = "Apache 2.0"
  s.license      = { :type => 'Apache License, Version 2.0', :text =>
    <<-LICENSE
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

    Copyright 2016 YEP.IO.

    LICENSE
  }
  s.authors = { 'YEP.IO' => 'heisonyee@126.com' }

  s.ios.deployment_target = '8.0'

  s.module_name = "AlamofireProtobuf"
  s.source_files = 'AlamofireProtobuf/*.{swift}'
  s.requires_arc = true
  s.frameworks   = 'Foundation'

  s.dependency 'Alamofire'
  s.dependency 'ProtocolBuffers-Swift'
end
