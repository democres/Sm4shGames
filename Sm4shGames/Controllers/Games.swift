//
//  Games.swift
//  Sm4shGames
//
//  Created by Creativo Calidad Grafica on 5/01/19.
//  Copyright © 2019 DavidF. All rights reserved.
//

import Foundation

class Games {
    
    var games = [Game]()
    
    init(games: [Game]) {
        self.games = games
    }
    
    func getPopularGames() -> [Game] {
        return self.games.filter({ $0.popular == true })
    }
    
    func getRecentGames() -> [Game] {

        var sortedByDate = [Game]()
        
        sortedByDate = games.filter({ $0.updatedAt != nil})
            
        sortedByDate.sorted(by: {
            $0.updatedAt!.compare($1.updatedAt!) == .orderedDescending
        })
        
        if sortedByDate.count > 1 {
            return Array(sortedByDate[0 ..< 5])
        }
        
        return games
        
    }
    
    func getAllBrands() -> [String] {
        
        var brands = [String]()
        
        for game in self.games {
            guard let brand = game.brand else {
                print("No brand in game")
                continue
            }
            brands.append(brand)
        }
        
        brands = Array(Set(brands)).sorted(by: { $0 < $1 })
        brands.insert("All", at: 0)
        
        return brands
        
    }
    
}
