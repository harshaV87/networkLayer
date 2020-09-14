//
//  URLParameterEncoder.swift
//  networkLayer
//
//  Created by Venkata harsha Balla on 8/8/20.
//  Copyright © 2020 BVH. All rights reserved.
//

import Foundation

// making sure tha the url request is appropriately constructed so as to not use up the quota if we have something as such. This module must be tested with the unit tests

public struct URLParameterEncoder :ParameterEncoder {
    
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        
        guard let url = urlRequest.url else { throw  NetworkError.missingURL}
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key , value) in parameters {
                
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                
                
                urlComponents.queryItems?.append(queryItem)
                
            }
            
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
        
    }
    
    
    
}
