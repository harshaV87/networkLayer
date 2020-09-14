//
//  NetworkRouter .swift
//  networkLayer
//
//  Created by Venkata harsha Balla on 8/8/20.
//  Copyright © 2020 BVH. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data : Data?, _ response: URLResponse?, _ error: Error?) -> ()

// getting the data from any end point and completing it with a request

protocol NetworkRouter: class {
    
    // making it a generic type - the end point
    associatedtype EndPoint: EndPointType
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
    
}
