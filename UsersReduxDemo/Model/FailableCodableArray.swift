//
//  FailableCodableArray.swift
//  UsersReduxDemo
//
//  Created by Hager Elsayed on 18/09/2022.
//

import Foundation
struct FailableCodableArray<Element : Codable> : Codable {

    var elements: [Element]

    init(from decoder: Decoder) throws {

        var container = try decoder.unkeyedContainer()

        var elements = [Element]()
        if let count = container.count {
            elements.reserveCapacity(count)
        }

        while !container.isAtEnd {
            if let element = try container
                .decode(FailableDecodable<Element>.self).base {

                elements.append(element)
            }
        }

        self.elements = elements
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(elements)
    }
}
