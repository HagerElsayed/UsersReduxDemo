//
//  FailableDecodable.swift
//  UsersReduxDemo
//
//  Created by Hager Elsayed on 18/09/2022.
//

import Foundation
struct FailableDecodable<Base : Decodable> : Decodable {

    let base: Base?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.base = try? container.decode(Base.self)
    }
}
