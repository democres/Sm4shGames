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
    let headers: HTTPHeaders = [
        "X-Parse-Application-Id": "I9pG8SLhTzFA0ImFkXsEvQfXMYyn0MgDBNg10Aps",
        "X-Parse-REST-API-Key": "Yvd2eK2LODfwVmkjQVNzFXwd3N0X7oUuwiMI3VDZ"]
    
    func fetchGames(completion: @escaping ([Game]) -> Void ) {

        AF.request(API_URL, headers: self.headers).responseJSON { response in
            if((response.result.value) != nil) {
                
                let swiftyJsonVar = JSON(response.result.value!)
                
                if let resData = swiftyJsonVar["results"].arrayObject {
                    let gamesJson = resData as! [[String:AnyObject]]
                    
                    var games = [Game]()
                    for game in gamesJson {
                        games.append(Game(objectId: game["objectId"] as? String,
                                          name: game["name"] as? String,
                                          brand: game["brand"] as? String,
                                          price: game["price"] as? String,
                                          imageUrl: game["imageURL"] as? String,
                                          genre: game["genre"] as? String,
                                          popular: game["popular"] as? Bool,
                                          updatedAt: game["updatedAt"] as? Date,
                                          createdAt: game["createdAt"] as? Date))
                    }
                    completion(games)
                }
            }
        }

    }
    
    func getArray(){
//        https://parseapi.back4app.com/
        
    }


}
