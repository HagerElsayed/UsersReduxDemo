//
//  UserListView.swift
//  UsersReduxDemo
//
//  Created by Hager Elsayed on 19/09/2022.
//

import SwiftUI

struct UserListView: View {
    @EnvironmentObject var store: AppStore
 
   
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Users")
                        .font(.largeTitle.bold())


                    Spacer()

                    NavigationLink {
                       //TODO: Navigate to Add User Form

                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.userAccentColor)
                    }

                }
                .padding()
                .onAppear {
                    //TODO: dispatch fetching User
                    self.store.dispatch(.user(action: .fetch))
                }
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(self.store.state.user.users, id:\.self) { user in
                            ZStack(alignment: .bottom) {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(user.name ?? "")
                                        .font(.system(size: 14))
                                        .foregroundColor(.userNameColor)
                                    HStack {
                                        Text(user.email ?? "")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 12))
                                        Spacer()
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width / 1.4)
                                .padding()
                                .padding(.bottom, 10)
                                .background(Color.white)
                                .cornerRadius(25)

                            }

                        }
                    }
                }

            }
            .background(Color.backgroundColor)
            .padding(.bottom, 20)
            .navigationBarTitleDisplayMode(.inline)

        }

        
        
    }

}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
