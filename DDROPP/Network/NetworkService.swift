//
//  NetworkService.swift
//  DDROPP
//
//  Created by Victor YAN on 23/07/2024.
//

import Foundation
import RxSwift

enum NetworkError: Error {
    case badURL
    case requestFailed
    case unknown
}

protocol NetworkServiceProtocol {
    func get<T: Decodable>(path: String) -> Single<T>
}

final class NetworkService: NetworkServiceProtocol {
    static private let host = "https://6690ef0926c2a69f6e8db7bc.mockapi.io/api/v1"

    func get<T: Decodable>(path: String) -> Single<T> {
        return request(path: path, method: "GET")
    }

    private func request<T: Decodable>(path: String, method: String) -> Single<T> {
        return Single.create { single in
            guard let url = URL(string: "\(Self.host)\(path)") else {
                single(.failure(NetworkError.badURL))
                return Disposables.create()
            }

            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method

            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    print("❌ Request failed with error: \(error.localizedDescription)")
                    single(.failure(NetworkError.requestFailed))
                    return
                }

                guard let data = data else {
                    // impossible path
                    single(.failure(NetworkError.unknown))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let decodedResponse = try decoder.decode(T.self, from: data)
                    print("✅ \(method): \(path) call successful")
                    single(.success(decodedResponse))
                } catch {
                    print("❌ Failed to decode JSON with error: \(error.localizedDescription)")
                    single(.failure(NetworkError.unknown))
                }
            }
            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}
