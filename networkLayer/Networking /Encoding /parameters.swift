//
//  parameters.swift
//  networkLayer
//
//  Created by Venkata harsha Balla on 8/8/20.
//  Copyright © 2020 BVH. All rights reserved.
//

import Foundation

// inout changes the original value , without creating a copy

public typealias Parameters = [String:Any]

public protocol ParameterEncoder {
    
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
    
}

public enum  NetworkError : String, Error {
    
    case paramatersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
    
    
}
