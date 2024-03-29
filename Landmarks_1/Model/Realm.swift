//
//  Data.swift
//  Landmarks_1
//
//  Created by sjp on 2021/12/18.
//

import Foundation
import RealmSwift
import CoreLocation
import SwiftUI

enum Category: String, PersistableEnum, CaseIterable, Codable {
    case lakes = "Lakes"
    case rivers = "Rivers"
    case mountains = "Mountains"
    case citys = "Citys"
}


enum Season: String, PersistableEnum, CaseIterable, Identifiable {
    case spring = "🌷"
    case summer = "🌞"
    case autumn = "🍂"
    case winter = "☃️"

    var id: String { rawValue }
}

final class LandmarkData: Object, ObjectKeyIdentifiable, Codable, Identifiable{
    @Persisted(primaryKey: true) var id: Int?
    @Persisted var name: String = ""
    @Persisted var park: String = ""
    @Persisted var state: String = ""
    @Persisted var _description: String = ""
    @Persisted var isFavorite: Bool = false
    @Persisted var isFeatured: Bool = false

//    override static func primaryKey() -> String? {
//        return "id"
//    }
    
    convenience init(id: Int) {
        self.init()
        self.id = id
    }


}

final class LandmarkGroup: Object, ObjectKeyIdentifiable {
    /// The unique ID of the Group. `primaryKey: true` declares the
    /// _id member as the primary key to the realm.
    @Persisted(primaryKey: true) var _id: ObjectId

    /// The collection of Items in this group.
    @Persisted var landmarkdatas = RealmSwift.List<LandmarkData>()
}

class ProfileData: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var username: String
    @Persisted var prefersNotifications = true
    @Persisted var seasonalPhoto: Season?
    @Persisted var goalDate = Date()
}

//func jsonAdd() {
//    
//    if let path = Bundle.main.path(forResource: "Data", ofType: "json") {
//        do {
//            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//            let try! JSONSerialization.jsonObject(with: data, options: [])
//            
//            for (index,subJson):(String, JSON) in json {
//                
//                do {
//                    try realm.write {
//                        
//                        realm.create(Item.self, value: subJson, update: .modified)
//                        
//                    }
//                    
//                } catch let error as NSError {
//                    print("Unable to write")
//                    print(error)
//                }
//                
//            }
//            
//        } catch {
//            print("Error")
//        }
//        
//    }
//}

//for (key,subJson):(String, JSON) in jsonObjects {
//
//    let thisItem = LandmarkData()
//    thisItem.id = subJson["id"].intValue
//    thisItem.name = subJson["name"].stringValue
//    thisItem.visable = subJson["viewable"].boolValue
//    thisItem.weapon = subJson["weapon"].boolValue
//    thisItem.vehicle = subJson["vehicle"].boolValue
//
//    let genreArray = subJson["genres"].arrayValue
//
//    for genre in genreArray {
//        let string = genre.stringValue
//        let predicate = NSPredicate(format: "name = %@", string)
//
//        if let foundGenre = realm.objects(Genres.self).filter(predicate).first {
//            thisItem.genres.append(foundGenre)
//        }
//    }
//
//    do {
//        try realm.write {
//            realm.create(Item.self, value: thisItem, update: .modified)
//        }
//
//    } catch let error as NSError {
//        print("Unable to write")
//        print(error)
//    }
//}
