//
//  Alamofire+Protobuf.swift
//  AlamofireProtobuf
//
//  Created by 仕炜 叶 on 16/2/14.
//  Copyright © 2016年 YEP.IO. All rights reserved.
//

import Foundation
import Alamofire
import Protobuf

public func request(
    _ method: Alamofire.Method,
    _ URLString: URLStringConvertible,
    message: GPBMessage)
    -> Request
{
    return Manager.sharedInstance.request(method, URLString, message: message)
}
