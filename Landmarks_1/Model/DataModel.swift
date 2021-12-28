//
//  LandmarkDatabase.swift
//  Landmarks_1
//
//  Created by sjp on 2021/12/17.
//
import Foundation
import RealmSwift

class DataModel: Object{
    @Persisted(primaryKey: true) var _id : ObjectId
    @Persisted var name: String = ""
    @Persisted var age: Int?
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
