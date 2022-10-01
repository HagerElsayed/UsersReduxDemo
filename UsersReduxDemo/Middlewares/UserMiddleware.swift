//
//  UserMiddleware.swift
//  UsersReduxDemo
//
//  Created by Hager Elsayed on 19/09/2022.
//

import Foundation
import Combine

typealias Middleware<State, Action> = (State, Action) -> AnyPublisher<Action, Never>?
func UserMiddleware(service: UserLoader) -> Middleware<AppState, AppAction> {
    return { state, action in
        
        switch(action) {
            
        case .user(action: .fetch):
            return service.getUsers(url: Constants.API_URL)
                .subscribe(on: DispatchQueue.main)
                .map { AppAction.user(action: .fetchComplete(users: $0)) }
                .catch { (error: NetworkError) -> Just<AppAction> in
                    switch(error) {
                    case .invalidURL:
                        return Just(AppAction.user(action: .fetchError(error: NetworkError.invalidURL)))
                    case .noData:
                        return Just(AppAction.user(action: .fetchError(error: NetworkError.noData)))
                    case .decodingError:
                        return Just(AppAction.user(action: .fetchError(error: NetworkError.decodingError)))
                    }
                    
                }
                .eraseToAnyPublisher()
        default: break
        }
        return Empty().eraseToAnyPublisher()
        
    }
    
}
