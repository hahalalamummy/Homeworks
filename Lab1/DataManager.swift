//
//  DataManager.swift
//  Lab1
//
//  Created by Admin on 11/20/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation

let kDatabaseName = "pokemon"
let kDatabaseExtension = "db"

class DataManager: NSObject {
    var pokemon: [ModelPokemon] = [ModelPokemon]()
    
    static let shared: DataManager = DataManager()
    
    static let defautManager = DataManager()
    
    func getDatabaseFolderPath() -> String {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory , .userDomainMask, true)[0]
        return documentPath + "/" + kDatabaseName + "." + kDatabaseExtension
    }
    
    // 1.Copy database
    func copyDatabaseIfNeed() {
        let bundlePath = Bundle.main.path(forResource: kDatabaseName, ofType: kDatabaseExtension)
        // 2. Get document path
        let documentPath = self.getDatabaseFolderPath()
        print(documentPath)
        // 3. Check if file exist
        if !FileManager.default.fileExists(atPath: documentPath)
        {
            // 4. copy from bundlePath to documentPath
            do{
                print(String(describing: bundlePath) + String(documentPath))
                try FileManager.default.copyItem(atPath: bundlePath!, toPath: documentPath)
            } catch {
                print(error)
            }
        }
    }
    
    func listAllPokemon() -> [ModelPokemon]{
        //pokemon.reserveCapacity(749)
        let database = FMDatabase(path: self.getDatabaseFolderPath())
        database?.open()
        
        let select = "SELECT * FROM pokemon"
        
        
        //pokemon.append(pokemon2)
        do{
            let result = try database?.executeQuery(select, values: nil)
            while (result?.next())! {
                let pokemon2 = ModelPokemon()
//                print(result?.int(forColumn: "StudentID"))
//                print(result?.string(forColumn: "Name"))
//                print(result?.int(forColumn: "Age"))
//                pokemon[i].id = (result?.int(forColumn: "id"))!
//                pokemon[i].name = (result?.string(forColumn: "name"))!
//                pokemon[i].tag = (result?.string(forColumn: "tag"))!
//                pokemon[i].gen = (result?.int(forColumn: "gen"))!
//                pokemon[i].img = (result?.string(forColumn: "img"))!
//                pokemon[i].color = (result?.string(forColumn: "color"))!
//                i += 1
                pokemon2.id = (result?.int(forColumn: "id"))!
                pokemon2.name = (result?.string(forColumn: "name"))!
                pokemon2.tag = (result?.string(forColumn: "tag"))!
                pokemon2.gen = (result?.int(forColumn: "gen"))!
                pokemon2.img = (result?.string(forColumn: "img"))!
                pokemon2.color = (result?.string(forColumn: "color"))!
                
                pokemon.append(pokemon2)
            }
            print("Select Successfully")
        } catch {
            print("Error:",error)
        }
        
        return pokemon
    }
    
    func insertStudent() {
        // 1.Open database
        let database = FMDatabase(path: self.getDatabaseFolderPath())
        database?.open()
        // 2. Create query
        let insertS = "INSERT INTO Student VALUES (1,'HauBui',27)"
        // 3.Excute query
        do {
            try database?.executeUpdate(insertS, values: nil)
            print("Suscess")
        } catch {
            print("error: ",error)
        }
        
        
        
        // 4.Close connect
        database?.close()
    }
    
    func getPokemon(i:Int) -> ModelPokemon {
        return pokemon[i]
    }
}
