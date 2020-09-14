//
//  jsonParameterEncoder.swift
//  networkLayer
//
//  Created by Venkata harsha Balla on 8/8/20.
//  Copyright © 2020 BVH. All rights reserved.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder {
    
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        do {
            
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            
            urlRequest.httpBody = jsonAsData
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == "" {
                
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            
            
        } catch  {
            throw NetworkError.encodingFailed
        }
        
        
        
    }
    
    
    
    
}
