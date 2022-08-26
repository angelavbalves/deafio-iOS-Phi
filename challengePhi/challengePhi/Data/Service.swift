//
//  Service.swift
//  challengePhi
//
//  Created by Angela Alves on 22/08/22.
//

import Foundation

class Service {

    static var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"

    static func makeRequest<T: Decodable>(endpoint: Endpoint, page: Int = 1, _ completion: @escaping (Result<T, ErrorState>) -> Void) {

        if let url = makeUrlFrom(endpoint: endpoint) {
            let task = URLSession.shared.dataTask(with: url) { data, response, _ in
                guard let data = data else { return }

                if let response = response as? HTTPURLResponse {
                    switch response.statusCode {
                        case 200...299:
                            if let obj: T = decode(data) {
                                completion(.success(obj))
                            } else {
                                completion(.failure(.generic))
                            }
                        case 300...399:
                            return
                        case 400...499:
                            completion(.failure(.notFound))
                            return
                        case 500...599:
                            return
                        default:
                            return
                    }
                }
            }
            task.resume()
        } else {
            completion(.failure(.generic))
        }
    }

    private static func makeUrlFrom(endpoint: Endpoint) -> URLRequest? {
        guard let url = buildUrlFrom(endpoint: endpoint) else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(token, forHTTPHeaderField: "token")
        urlRequest.httpMethod = endpoint.method
        return urlRequest
    }

    private static func buildUrlFrom(endpoint: Endpoint) -> URL? {
        var component = URLComponents()
        component.scheme = "https"
        component.host = endpoint.host
        component.path = endpoint.path

        return component.url
    }

    private static func decode<T: Decodable>(_ data: Data) -> T? {
        do {
            let item = try JSONDecoder().decode(T.self, from: data)
            return item
        } catch {
            print(error)
        }
        return nil
    }
}
