//
//  Client.swift
//  Universities
//
//  Created by Mehmet Buğra BALCI on 11.10.2023.
//

import Foundation

struct ClientModel {
    var urlString: String
    var parameters: [String: Any]?
    var method: HTTPMethod? = .get
}

class Client {
    func request<T: Decodable>(clientModel: ClientModel, expecting: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: clientModel.urlString) else { return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = clientModel.method?.rawValue
        
        if let parameters = clientModel.parameters {
            request.httpBody = parameters.percentEncoded()
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  error == nil else {
                if let error = error {
                    completion(.failure(error))
                }
                print("!!! ERROR:", error ?? URLError.badServerResponse)
                return
            }
            
            guard (200...299) ~= response.statusCode else {
                print("!!! ERROR: \(response.statusCode)")
                return
            }
            
            do {
                let responseObject = try JSONDecoder().decode(expecting, from: data)
                print("Parameters: \(String(describing: clientModel.parameters?.percentEncoded()))")
                print("Response Data:")
                print(String(decoding: data, as: UTF8.self))
                completion(.success(responseObject))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
