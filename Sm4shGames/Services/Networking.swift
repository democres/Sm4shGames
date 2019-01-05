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
                        
                        var gameAux = Game(objectId: game["objectId"] as? String,
                                           name: game["name"] as? String,
                                           brand: game["brand"] as? String,
                                           price: game["price"] as? String,
                                           imageUrl: game["imageURL"] as? String,
                                           genre: game["genre"] as? String,
                                           popular: game["popular"] as? Bool,
                                           updatedAt: game["updatedAt"] as? Date,
                                           createdAt: game["createdAt"] as? Date)
                        
                        
                        let kSQLiteDateFormat : String = "yyyy/MM/dd HH:mm:ss Z"
                        let dateFormat = [kSQLiteDateFormat,
                                          "dd MM, yyyy",
                                          "MMM-yyyy",
                                          "yyyy-MM-dd",
                                          "yyyy-12",
                                          "yyyy/MM/dd",
                                          "yyyy/mm/dd",
                                          "yyyy-MM-dd HH:mm:ss",
                                          "yyyy-MM-dd HH:mm:ss Z",
                                          "yyyy-MM-dd HH:mm:ss K",
                                          "yyyy-MM-dd HH:mm:ss ZZ",
                                          "yyyy/MM/dd hh:mm a",
                                          "MM/dd/yyyy",
                                          "MM/dd/yyyy HH:mm:ss Z",
                                          "h:mm a",
                                          "hh:mm a",
                                          "yyyy/MM/dd HH:mm:ss Z",
                                          "yyyy/MM/dd h:mm a",
                                          "MM/dd/yyyy h:mm a",
                                          "yyyy-MM-dd h:mm a",
                                          "yyyy-MM-dd'T'hh:mm:ss",
                                          "yyyy/MM/dd h a",
                                          "yyyy-MM-dd'T'HH:mm:ss","dd MMM, yyyy","dd-MM-yyyy HH:mm", "EEE, MMM dd","MM/dd/yyyy hh:mm:ss a"]

                        if let dateString : String = game["updatedAt"] as? String {
                            let dateFormatter : DateFormatter = DateFormatter()
                            for format in dateFormat {
                                
                                dateFormatter.dateFormat =  format
                                if let date = dateFormatter.date(from: dateString) {
                                    gameAux.updatedAt = date
                                }
                            }
                        }
                        
                        games.append(gameAux)
                    }
                    completion(games)
                }
            }
        }

    }

}
