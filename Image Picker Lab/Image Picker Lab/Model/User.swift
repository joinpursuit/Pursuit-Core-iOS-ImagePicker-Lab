//
//  Usury.swift
//  Image Picker Lab
//
//  Created by Michelle Cueva on 10/1/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

struct User: Codable {
    let userName: String 
    let image: Data
    
    enum CodingKeys: String, CodingKey {
        case userName = "userName"
        case image
    }
}
