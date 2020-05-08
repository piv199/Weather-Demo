//
//  URLRequest+Network.swift
//  Weather
//
//  Created by Oleksii Pyvovarov on 08.05.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

struct AnyEncodable: Encodable {
    let encodable: Encodable

    func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
}

extension URLRequest {
    init(_ target: RequestConvertible, baseURL: URL?) throws {
        guard let baseURL = (baseURL ?? target.baseURL) else {
            throw URLError(.badURL, userInfo: ["baseURL": "Missing url base path when creating \(URLRequest.self)."])
        }
        let url = baseURL.appendingPathComponent(target.path)
        try self.init(url: url, method: target.method, headers: target.headers)
        try self.encode(for: target)
    }

    private mutating func encode(for target: RequestConvertible) throws {
        switch target.task {
        case .requestPlain: break
        case let .requestParameters(parameters, encoding):
            self = try encoding.encode(self, with: parameters)
        case let .requestJSONEncodable(encodable, encoder):
            headers.addIfMissing(.contentType("application/json"))
            self.httpBody = try encoder.encode(AnyEncodable(encodable: encodable))
        }
    }
}
