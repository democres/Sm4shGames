//
//  Game.swift
//  Sm4shGames
//
//  Created by Creativo Calidad Grafica on 5/01/19.
//  Copyright © 2019 DavidF. All rights reserved.
//

import Foundation

class Game {
    
    let objectId: String?
    let name: String?
    var brand: String?
    var price: String?
    var imageUrl: String?
    var genre: String?
    var popular: Bool?
    var rating: String?
    var downloads: String?
    var description: String?
    var SKU: String?
    var createdAt: Date?
    var updatedAt: Date?
    
    
    init(objectId: String?,
         name: String?,
         brand: String?,
         price: String?,
         imageUrl: String?,
         genre: String?,
         popular: Bool?,
         updatedAt: Date?,
         createdAt: Date?,
         description: String?,
         downloads: String?,
         sku: String?,
         rating: String?) {
        
        self.objectId = objectId
        self.name = name
        self.brand = brand
        self.price = price
        self.imageUrl = imageUrl
        self.genre = genre
        self.popular = popular
        self.updatedAt = updatedAt
        self.createdAt = createdAt
        self.description = description
        self.downloads = downloads
        self.SKU = sku
        self.rating = rating
        
    }
    
}
