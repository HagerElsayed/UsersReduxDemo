//
//  UserState.swift
//  UsersReduxDemo
//
//  Created by Hager Elsayed on 19/09/2022.
//

import Foundation

struct UserState {
    var users:[User] = [User]()
    var isFetching = false
    var fetchError: String?
}
