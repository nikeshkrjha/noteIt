//
//  ApiHandler.swift
//  NoteIt
//
//  Created by Nikesh Jha on 1/31/19.
//  Copyright © 2019 Nikesh Jha. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class ApiHandler {
    static func getAllNotes(responseJson: @escaping ([String: Any]?) -> Void = { _ in }){
        
        if !NetworkReachabilityManager()!.isReachable {
            print("No Internet")
            responseJson([:])
            return
        }
        
        var dataDict: [String:Any] = [:]
        Alamofire.request(Constants.baseURL + Constants.getAllNotes).validate()
            
            //            .responseString { response in
            ////                print("Response String: \(response.result.value)")
            //            }
            .responseJSON { (response) in
                print(response.request!)
                dataDict = response.result.value! as! [String: Any]
                debugPrint(response.result.value!)
                responseJson(dataDict)
        }
    }
    
    
    
    
    // With Alamofire
    static func fetchAllNotes(responseJson: @escaping ([String: Any]?) -> Void = { _ in }){
        guard let url = URL(string: Constants.baseURL + Constants.getAllNotes) else {
            responseJson([:])
            return
        }
        Alamofire.request(url, method: .get,parameters: [:])
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print(" Error while fetching remote rooms:")
                    responseJson([:])
                    return
                }
                
                guard let value = response.result.value as? [String: Any],
                    let _ = value["data"] as? [String: Any] else {
                        print("Malformed data received from fetchAllRooms service")
                        responseJson([:])
                        return
                }
                
                let notesDict = response.result.value as? [String: Any]
                responseJson(notesDict)
        }
    }
    

}
