//
//  Router.swift
//  networkLayer
//
//  Created by Venkata harsha Balla on 8/8/20.
//  Copyright © 2020 BVH. All rights reserved.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter {
    
    // fileprivate functions
    
    // responsible for encoding our parameters - bodyParameters and URLParameters
    
    // for special APIs , amendements must be made in configureParameters and in HTTPTask enum
    
    fileprivate func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        
        
        do {
            
            if let bodyParameters = bodyParameters {
                
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
                
            }
            
            if let urlParameters = urlParameters {
                
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
                
            }
            
            
        } catch {
            
            throw error
            
            
        }
        
        
    }
    
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        
        guard let headers = additionalHeaders else {return}
        
        for (key, value) in headers {
            
            request.setValue(value, forHTTPHeaderField: key)
            
        }
        
    }
    
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        
    var request = URLRequest(url: route.baseUrl.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        
        do {
            
            switch route.task {
                
            case .request:
                
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                
            case .requestParameters(let bodyParameters, let urlParameters) :
                
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
                
                
            case .requestParametersAndHeaders(let bodyParameters, let urlParameters, let  additionalHeaders) :
                
                self.addAdditionalHeaders(additionalHeaders, request : &request)
                
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
                
                
            }
            
            return request
            
        } catch  {
            
            throw error
            
        }
        
        
        
        
        
        
        
        
    }
    
    
    // making this private to rstrict the access
    
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        
        let session = URLSession.shared
        
        do {
            let request = try self.buildRequest(from: route)
            
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                
                completion(data, response, error)
            })
            
            
        } catch  {
            
            completion(nil, nil, error)
            
        }
        
        self.task?.resume()
        
    }
    
    func cancel() {
        
        self.task?.cancel()
        
    }
    

}
