//
//  UserState.swift
//  UsersReduxDemo
//
//  Created by Hager Elsayed on 19/09/2022.
//

import Foundation

struct UserState: Equatable {
    var users:[User] = [User]()
    var isFetching = false
    var fetchError: String?
    
    public static func == (lhs: UserState, rhs: UserState) -> Bool {
        lhs.users == rhs.users &&
        lhs.isFetching == rhs.isFetching &&
        lhs.fetchError == lhs.fetchError
    }
    
}
