//
//  UserService.swift
//  UsersReduxDemo
//
//  Created by Hager Elsayed on 18/09/2022.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidURL
    case decodingError
    case noData
}

enum CRUDOperation: String, CaseIterable {
    case get = "GET"
    case post = "Post"
}

protocol UserLoader {
   func  getUsers(url: String) -> AnyPublisher<[User], NetworkError>
}

class UsersService: UserLoader {
    func getUsers(url: String) -> AnyPublisher<[User], NetworkError> {
        return Future<[User], NetworkError> { promise in
            guard let url = URL(string: url) else {
                promise(.failure(.invalidURL))
                return
                
            }
            var request = URLRequest(url:  url)
            request.httpMethod = CRUDOperation.get.rawValue
            URLSession.shared.dataTask(with: request){ data, response, error in
                guard let data = data, error == nil else {
                    promise(.failure(.noData))
                    return
                }
                let userResponse =  try? JSONDecoder()
                    .decode([FailableDecodable<User>].self, from: data)
                    .compactMap { $0.base }
                if let userResponse = userResponse {
                    promise(.success(userResponse))
                } else {
                    promise(.failure(.decodingError))
                }
                
            }.resume()

        }
        .eraseToAnyPublisher()
      
    }
}

