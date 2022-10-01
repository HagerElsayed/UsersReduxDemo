//
//  User.swift
//  UsersReduxDemo
//
//  Created by Hager Elsayed on 18/09/2022.
//

import Foundation
import UIKit

struct User: Decodable, Hashable {
    let id: Int?
    let name: String?
    let email: String?
    let gender: String?
    let status: String?
    
    
    init(
        id: Int? = nil,
        name: String? = nil,
        email: String? = nil,
        gender: String? = nil,
        status: String? = nil
    ){
        self.id = id
        self.name = name
        self.email = email
        self.gender = gender
        self.status = status
        
    }
    
}
extension User {
    static let mockedData: [User] = [
        User(id: 1, name: "Hager", email: "hager@gmail.com", gender: "female", status: "")
    ]
}
