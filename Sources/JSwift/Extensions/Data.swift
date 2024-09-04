//
//  Data.swift
//  JSwift
//
//  Created by Jenya Lebid on 9/3/24.
//

import Foundation

public extension Data {
    
    static func fetch(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return data
    }
}
