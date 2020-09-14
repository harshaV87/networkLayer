//
//  enPointProtocol.swift
//  networkLayer
//
//  Created by Venkata harsha Balla on 8/8/20.
//  Copyright © 2020 BVH. All rights reserved.
//

import Foundation

// putting all thge information neeed to configure an endpoint

protocol EndPointType {
    
    var baseUrl: URL { get }
    var path: String{ get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
    
}
