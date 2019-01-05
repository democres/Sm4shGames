//
//  Networking.swift
//  Sm4shGames
//
//  Created by MacNapo on 12/28/18.
//  Copyright © 2018 DavidF. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Networking {
    
    let API_URL = "https://parseapi.back4app.com/classes/Product"
    
    func ImageGet(completion: @escaping ([String]) -> Void ) {
//        let imageId = Int(details.id!)
        let headers: HTTPHeaders = [
            "X-Parse-Application-Id": "I9pG8SLhTzFA0ImFkXsEvQfXMYyn0MgDBNg10Aps",
            "X-Parse-REST-API-Key": "Yvd2eK2LODfwVmkjQVNzFXwd3N0X7oUuwiMI3VDZ"]

        AF.request(API_URL, headers: headers).responseJSON { response in
            if((response.result.value) != nil) {
                
                let swiftyJsonVar = JSON(response.result.value!)
                
                if let resData = swiftyJsonVar["results"].arrayObject {

                    let games = resData as! [[String:AnyObject]]
                    
                    let gamesImages =  games.map({$0["imageURL"] as! String})
                    
                    completion(gamesImages)
                }
            }
        }

    }
    
    func getArray(){
//        https://parseapi.back4app.com/
        
    }


}
