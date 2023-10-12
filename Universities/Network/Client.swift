//
//  Client.swift
//  Universities
//
//  Created by Mehmet Buğra BALCI on 11.10.2023.
//

import Foundation

class Client {
    func request<T: Decodable>(urlString: String, parameters: [String: Any]?, expecting: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        
//        request.httpMethod = "POST"
        
        if let parameters = parameters {
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
                completion(.success(responseObject))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

extension Dictionary {
    func percentEncoded() -> Data? {
        map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryCalueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryCalueAllowed) ?? ""
            
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryCalueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed: CharacterSet = .urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}