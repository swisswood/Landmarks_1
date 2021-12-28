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
    @Persisted dynamic var id: Int = 0
    @Persisted dynamic var name: String = ""
    @Persisted dynamic var park: String = ""
    @Persisted dynamic var state: String = ""
    @Persisted dynamic var _description: String = ""
    @Persisted dynamic var isFavorite: Bool = false
    @Persisted dynamic var isFeatured: Bool = false

    override static func primaryKey() -> String? {
        return "id"
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
    @Persisted dynamic var username: String
    @Persisted dynamic var prefersNotifications = true
    @Persisted dynamic var seasonalPhoto: Season?
    @Persisted dynamic var goalDate = Date()
}
