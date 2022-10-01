//
//  TestHelper.swift
//  UsersReduxDemoTests
//
//  Created by Hager Elsayed on 27/09/2022.
//

import Foundation
import XCTest
import SwiftUI
import Combine
@testable import UsersReduxDemo
// MARK: - Result

extension Result where Success: Equatable {
    func assertSuccess(value: Success, file: StaticString = #file, line: UInt = #line) {
        switch self {
        case let .success(resultValue):
            XCTAssertEqual(resultValue, value, file: file, line: line)
        case let .failure(error):
            XCTFail("Unexpected error: \(error)", file: file, line: line)
        }
    }
}
