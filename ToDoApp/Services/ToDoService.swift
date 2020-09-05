//
//  ToDoService.swift
//  ToDoApp
//
//  Created by Ryniere dos Santos Silva on 2020-09-05.
//  Copyright © 2020 Ryniere dos Santos Silva. All rights reserved.
//

import Foundation

class ToDoService {
    
    public static let shared = ToDoService()
    
    private let baseAPIURL = "https://jsonplaceholder.typicode.com"
    private let urlSession = URLSession.shared
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    public func fetchToDos( successHandler: @escaping (_ response: [ToDo]) -> Void, errorHandler: @escaping(_ error: Error) -> Void) {
        
        guard let urlComponents = URLComponents(string: "\(baseAPIURL)/todos") else {
            errorHandler(ToDoError.invalidEndpoint)
            return
        }
        
        guard let url = urlComponents.url else {
            errorHandler(ToDoError.invalidEndpoint)
            return
        }
        
        urlSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.handleError(errorHandler: errorHandler, error: ToDoError.apiError)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.handleError(errorHandler: errorHandler, error: ToDoError.invalidResponse)
                return
            }
            
            guard let data = data else {
                self.handleError(errorHandler: errorHandler, error: ToDoError.noData)
                return
            }
            
            do {
                let todoList = try self.jsonDecoder.decode([ToDo].self, from: data)
                DispatchQueue.main.async {
                    successHandler(todoList)
                }
            } catch {
                self.handleError(errorHandler: errorHandler, error: ToDoError.serializationError)
            }
        }.resume()
        
    }
    
    
    private func handleError(errorHandler: @escaping(_ error: Error) -> Void, error: Error) {
        DispatchQueue.main.async {
            errorHandler(error)
        }
    }
}

public enum ToDoError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
}
