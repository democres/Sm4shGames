//
//  DatabaseController.swift
//  Sm4shGames
//
//  Created by Test on 1/11/19.
//  Copyright © 2019 DavidF. All rights reserved.
//

import Foundation
import CouchbaseLiteSwift

class DatabaseController {
    
    // MARK: - Properties
    
    static let shared = DatabaseController()
    
    var database: Database!

    private init() {
        
        // Get the database (and create it if it doesn’t exist).
        
        do {
            self.database = try Database(name: "sm4shDB")
        } catch {
            fatalError("Error opening database")
        }
        
    }
    
    public func saveGame(objectId: String?,
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
        
        
        // Create a new document (i.e. a record) in the database.
        let game = MutableDocument()
            .setString(objectId, forKey: "objectId")
            .setString(name, forKey: "name")
            .setString(brand, forKey: "universe")
            .setString(price, forKey: "price")
            .setString(imageUrl, forKey: "imageURL")
            .setString(genre, forKey: "genre")
            .setBoolean(popular!, forKey: "popular")
            .setDate(updatedAt, forKey: "updatedAt")
            .setDate(createdAt, forKey: "createdAt")
            .setString(description, forKey: "description")
            .setString(downloads, forKey: "downloads")
            .setString(sku, forKey: "SKU")
            .setString(rating, forKey: "rating")
        
        
        // Save it to the database.
        do {
            try self.database.saveDocument(game)
        } catch {
            fatalError("Error saving game")
        }
    
    }
    
    
    
    
    public func updateDoc(doc: MutableDocument){
        
        // Update a document.
        
        if let mutableDoc = self.database.document(withID: doc.id)?.toMutable() {
            mutableDoc.setString("Swift", forKey: "language")
            do {
                try self.database.saveDocument(mutableDoc)
                
                let document = self.database.document(withID: doc.id)!
                // Log the document ID (generated by the database)
                // and properties
                print("Document ID :: \(document.id)")
                print("Learning \(document.string(forKey: "language")!)")
                print("Learning \(document.string(forKey: "type")!)")
            } catch {
                fatalError("Error updating document")
            }
        }
        
    }
    
    public func getGames() -> [Game]? {
        
        var gamesArray = [Game]()
        
        let query = QueryBuilder
            .select(
                SelectResult.property("objectId"),
                SelectResult.property("name"),
                SelectResult.property("universe"),
                SelectResult.property("price"),
                SelectResult.property("imageURL"),
                SelectResult.property("genre"),
                SelectResult.property("popular"),
                SelectResult.property("updatedAt"),
                SelectResult.property("createdAt"),
                SelectResult.property("description"),
                SelectResult.property("downloads"),
                SelectResult.property("SKU"),
                SelectResult.property("rating")
            )
            .from(DataSource.database(database!))
        
        do {
        
            for result in try query.execute() {
                
                let gameAux = Game(objectId: result.string(forKey: "objectId"),
                                   name: result.string(forKey: "name"),
                                   brand: result.string(forKey: "universe"),
                                   price: result.string(forKey: "price"),
                                   imageUrl: result.string(forKey: "imageURL"),
                                   genre: result.string(forKey: "genre"),
                                   popular: result.boolean(forKey: "popular"),
                                   updatedAt: result.date(forKey: "updatedAt"),
                                   createdAt: result.date(forKey: "createdAt"),
                                   description: result.string(forKey: "description"),
                                   downloads: result.string(forKey: "downloads"),
                                   sku: result.string(forKey: "SKU"),
                                   rating: result.string(forKey: "rating"))
                
                gamesArray.append(gameAux)
                
            }
            
        } catch {
            print(error)
        }
        
        return gamesArray
        
    }
    
    func clearDatabase(){
        
        do {
            if self.database != nil {
                try self.database.delete()
            }
            self.database = try Database(name: "sm4shDB")
        } catch {
            fatalError("Error clearing database")
        }
        
    }
    
    
}
