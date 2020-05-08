//
//  RequestConvertible.swift
//  Weather
//
//  Created by Oleksii Pyvovarov on 08.05.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

protocol RequestConvertible {
    /// The base `URL` to use for the current request. Return nil to use Component-defined base `URL`.
    var baseURL: URL? { get }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }

    /// The HTTP method used in the request.
    var method: Network.Method { get }

    /// The type of HTTP task to be performed.
    var task: Network.Task { get }

    /// The headers to be used in the request.
    var headers: Network.Headers? { get }
}

extension RequestConvertible {
    var baseURL: URL? { nil }
    var method: Network.Method { .get }
    var headers: Network.Headers? { nil }
}

extension Network {
    struct Request: RequestConvertible {
        // MARK: - Properties

        let baseURL: URL?
        let path: String
        let method: Network.Method
        let task: Network.Task
        let headers: Network.Headers?

        // MARK: - Lifecycle

        init(baseURL: URL? = nil, path: String, method: Network.Method = .get, task: Network.Task,
             headers: Network.Headers? = nil) {
            self.baseURL = baseURL
            self.path = path
            self.method = method
            self.task = task
            self.headers = headers
        }
    }
}
