//
//  UserReducer.swift
//  UsersReduxDemo
//
//  Created by Hager Elsayed on 19/09/2022.
//

import Foundation

// reducer(state, action)
func userReducer(state: inout UserState, action: UserAction) -> Void {
    switch(action) {
    case .fetch:
        state.fetchError = nil
        state.isFetching = true
    case .fetchComplete(users: let users):
        state.fetchError = nil
        state.isFetching = false
        state.users = users
    case .fetchError(error: let error):
        state.isFetching = false
        switch error {
        case .invalidURL:
            state.fetchError = "Invalid URL, please check it again"
        default:
            state.fetchError = "something went wrong!"
        }
        
    }
    
}
