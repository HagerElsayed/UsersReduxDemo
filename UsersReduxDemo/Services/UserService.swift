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

class UsersService {
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
    
    func addUser(url: String, user: User)  -> AnyPublisher<User, NetworkError>{
        let urlWithAuth = "\(url)?access-token=9358beb9c6b3435b2bb37b172bc11176070d51a0b07b6edcbf0fcd89423eb0ba"
        return Future<User, NetworkError> { promise in
        guard let url = URL(string: urlWithAuth) else {
            promise(.failure(.invalidURL))
            return
            
        }
        let parameters: [String: Any] = [
            "id": user.id ?? 0,
            "name": user.name ?? "",
            "email": user.email ?? "",
            "gender": user.gender ?? "",
            "status": user.status ?? ""
        ]
        print("parameters", parameters)
        var request = URLRequest(url:  url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = CRUDOperation.post.rawValue
        do {
           request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            print("request", request)
            
            URLSession.shared.dataTask(with: request){ data, response, error in
                guard let data = data, error == nil else {
                    promise(.failure(.noData))
                    return
                }
                let userResponse =  try? JSONDecoder()
                    .decode(User.self, from: data)
                if let userResponse = userResponse {
                    promise(.success(userResponse))
                } else {
                    promise(.failure(.decodingError))
                }
                
            }.resume()
         } catch let error {
           print(error.localizedDescription)
           return
         }
        }
        .eraseToAnyPublisher()
        
    }
   
}
