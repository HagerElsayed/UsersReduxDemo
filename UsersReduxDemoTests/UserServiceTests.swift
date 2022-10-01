//
//  UserServiceTests.swift
//  UsersReduxDemoTests
//
//  Created by Hager Elsayed on 25/09/2022.
//

import XCTest
import Combine
import SwiftUI
@testable import UsersReduxDemo
class UserServiceTests: XCTestCase {
    private var mockUsersClient: MockUserClient!
    private var cancellables: Set<AnyCancellable>!

    override func setUp()  {
        super.setUp()
        mockUsersClient = MockUserClient()
        cancellables = []
    }
    
    override func tearDown()  {
        mockUsersClient = nil
        cancellables = nil
        super.tearDown()
    }

    // MARK: test trial - need to revisit it again
    func test_loadUser_Empty_success() async {
        let data = User.mockedData
        let store = AppStore(
            state: .init(user: UserState()),
            reducer: appReducer,
            middlewares: [
                UserMiddleware(service: mockUsersClient)
            ]
        )
        
        let expectation = XCTestExpectation(description: "State is set to populated")
        store.$state.dropFirst().sink { state in
            XCTAssertEqual(state, .init(user: .init(users: [], isFetching: true, fetchError: nil)))
            expectation.fulfill()
        }.store(in: &cancellables)
        mockUsersClient.fetchUsersResult = Result.success(data).publisher.eraseToAnyPublisher()
        store.dispatch(.user(action: .fetch))
       wait(for: [expectation], timeout: 2)
    }
}
