//
//  ContentView.swift
//  UsersReduxDemo
//
//  Created by Hager Elsayed on 18/09/2022.
//

import SwiftUI

struct ContentView: View {
    let store = AppStore(
        state: .init(user: UserState()),
        reducer: appReducer,
        middlewares: [
            UserMiddleware(service: UsersService())
        ]
    )
    var body: some View {
        UserListView()
            .environmentObject(store)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
