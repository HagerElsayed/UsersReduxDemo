//
//  UserLoaderStub.swift
//  UsersReduxDemoTests
//
//  Created by Hager Elsayed on 25/09/2022.
//

import Foundation
import Combine
import SwiftUI
@testable import UsersReduxDemo
final class MockUserClient: UserLoader {
    var fetchUsersResult: AnyPublisher<[User], NetworkError>!
    func getUsers(url: String) -> AnyPublisher<[User], NetworkError> {
        return fetchUsersResult
    }
}
