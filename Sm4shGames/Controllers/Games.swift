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
    
    func getRecentGames() -> [Game] {

        var sortedByDate = [Game]()
        
        sortedByDate = self.games.filter({ $0.updatedAt != nil})
        sortedByDate.sorted(by: {
            $0.updatedAt!.compare($1.updatedAt!) == .orderedDescending
        })

        if sortedByDate.count >= 5 {
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
    
    
    //MARK: FILTERS
    
    func getPopularGames() -> [Game] {
        return self.games.filter({ $0.popular == true })
    }
    
    func getGamesByBrand(brand: String) -> [Game] {
        return self.games.filter({ $0.brand == brand })
    }
    
    
    func filterByRange(min: Double, max: Double) -> [Game]{
        
        return self.games.filter({
            let price = $0.price!.doubleValue
            return price >= min && price <= max
        })
    }
    
    func filterByRating(rating: Int) -> [Game]{
        
        return self.games.filter({
            return Int($0.rating!) == rating
        })
    }
    
    func getMaxPrice() -> Double {
        let sortedArray = self.games.sorted(by: { $0.price!.doubleValue > $1.price!.doubleValue })
    
        return sortedArray[0].price!.doubleValue
    }
    
    func getMinPrice() -> Double {
        let sortedArray = self.games.sorted(by: { $0.price!.doubleValue > $1.price!.doubleValue })
        
        return sortedArray[sortedArray.count - 1].price!.doubleValue
    }
    
    
    //MARK: SORTS
    
    func sortByDownloads() -> [Game] {
        
        return self.games.sorted(by: {
            $0.downloads!.compare($1.downloads!) == .orderedDescending
        })
        
    }
    
    func sortByDate() -> [Game] {
        
        var sortedByDate = [Game]()
        sortedByDate = games.filter({ $0.updatedAt != nil})
        
        return sortedByDate.sorted(by: {
            $0.updatedAt!.compare($1.updatedAt!) == .orderedDescending
        })
    }
    
    func sortByPrice() -> [Game] {
 
        return  self.games.sorted(by: {
            $0.price!.doubleValue > $1.price!.doubleValue
        })
    }

 
    
}
