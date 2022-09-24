//
//  AppReducer.swift
//  UsersReduxDemo
//
//  Created by Hager Elsayed on 19/09/2022.
//

import Foundation

typealias Reducer<State, Action> = (inout State, Action) -> Void

func appReducer(state: inout AppState, action: AppAction) -> Void {
    switch(action) {
    case .user(action: let action):
        userReducer(state: &state.user, action: action)
    }
}
