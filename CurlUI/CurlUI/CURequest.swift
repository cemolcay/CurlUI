//
//  CURequest.swift
//  CurlUI
//
//  Created by Cem Olcay on 28/10/15.
//  Copyright © 2015 prototapp. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON

enum CURequestMethod: Int {
    case GET = 0
    case POST = 1

    var AlamofireMethod: Alamofire.Method {
        switch self {
        case .GET:
            return .GET
        case .POST:
            return .POST
        }
    }
}

class CURequest {
    class func request(
        url: String,
        method: CURequestMethod,
        parameters: [String: AnyObject]?,
        success: (String) -> Void) {
        Alamofire.request(method.AlamofireMethod, url, parameters: parameters, encoding: .JSON, headers: nil)
        .responseJSON { response in
            switch response.result {
            case .Success(let value):
                let swiftyJson = JSON(value)
                success("\(swiftyJson)")
            case Result.Failure(let error):
                success(error.description)
            }
        }
    }
}
