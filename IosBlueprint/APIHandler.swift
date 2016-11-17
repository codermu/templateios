//
//  APIHandler.swift
//  IosBlueprint
//
//  Created by ibrahim on 11/14/16.
//  Copyright © 2016 Indosytem. All rights reserved.
//

import Foundation
import Alamofire

typealias appJSON = [String : AnyObject]
typealias postParam = Parameters

struct apiResponse {
    let status  : String
    let message : [String]?
    let data    : AnyObject?
    
    init(status:String ,message rspMsg : [String]? ,data rspData : AnyObject?) {
        self.status     = status
        self.message    = rspMsg
        self.data       = rspData
    }
}

class APIHandler {
    // handle api request using alamofire
    class func request( url : String ,requestMethod method : HTTPMethod = .get ,requestParam parameter : Parameters? = nil,requestEncoding encoding : ParameterEncoding = URLEncoding.default ,requestHeaders headers : HTTPHeaders? = nil , callback : @escaping (appJSON) -> Void){
        
        Alamofire.request(url, method: method, parameters: parameter, encoding: encoding, headers: headers).responseJSON(completionHandler: { response in
            
            // debug response
            //debugPrint(response)
            
            switch response.result {
            // Automatically validates status code within 200...299 range, and that the Content-Type header of the response matches the Accept header of the request, if one is provided
            case .success:
                
                if let data = parseData(JSONData: response.data!){
                    callback(data)
                }
                
            case .failure(let error):
                
                print(error)
                
            }
            
        })
    }
}

func parseData(JSONData : Data)->appJSON?{
    do {
        let readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! appJSON
        return readableJSON
    } catch{
        print(error)
        return nil
    }
}

func parseJsonToString(object : AnyObject)->[String]{
    
    var objArr = [String]()
    
    if let objs = object as? appJSON{
        for (_,obj) in objs{
            print(obj)
            objArr.append(obj[0] as! String)
        }
    }
    
    return objArr
}
