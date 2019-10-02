//
//  UserPersistence.swift
//  Image Picker Lab
//
//  Created by Michelle Cueva on 10/1/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

struct UserPersistenceHelper {
    
    static let manager = UserPersistenceHelper()
    
    func save(user: User) throws {
        try persistenceHelper.save(newElement: user)
    }
    
    func getUser() throws -> [User] {
        return try persistenceHelper.getObjects()
    }
    
    private let persistenceHelper = PersistenceHelper<User>(fileName: "usersInfo.plist")
    
    private init() {}
}
