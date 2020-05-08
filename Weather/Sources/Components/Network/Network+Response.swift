//
//  Network+Response.swift
//  Weather
//
//  Created by Oleksii Pyvovarov on 08.05.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

extension Network {
    class Response {
        // MARK: - Properties

        let data: Data?
        let response: HTTPURLResponse
        let request: URLRequest?
        let metrics: URLSessionTaskMetrics?

        var statusCode: Int { response.statusCode }

        // MARK: - Lifecycle

        init(data: Data?,
             response: HTTPURLResponse,
             request: URLRequest? = nil,
             metrics: URLSessionTaskMetrics? = nil) {
            self.data = data
            self.request = request
            self.response = response
            self.metrics = metrics
        }
    }
}

extension Network.Response {
    func decode<T: Decodable>(_ type: T.Type, decoder: JSONDecoder) throws -> T {
        return try decoder.decode(T.self, from: data ?? Data())
    }

    func decode<T: Decodable>(_ type: T.Type) throws -> T {
        return try decode(T.self, decoder: JSONDecoder())
    }
}

import Alamofire

extension Network.Response {
    convenience init(_ dataResponse: AFDataResponse<Data?>) throws {
        switch dataResponse.result {
        case .success(let data):
            guard let response = dataResponse.response else {
//                throw NetworkError.missingResponse
                fatalError()
            }
            self.init(data: data,
                      response: response,
                      request: dataResponse.request,
                      metrics: dataResponse.metrics)
        case .failure(let error):
            throw error
        }
    }
}
