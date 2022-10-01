//
//  AppState.swift
//  UsersReduxDemo
//
//  Created by Hager Elsayed on 19/09/2022.
//

import Foundation

struct AppState: Equatable {
    var user: UserState
    
    public static func == (lhs: AppState, rhs: AppState) -> Bool {
        lhs.user == rhs.user
    }
}
