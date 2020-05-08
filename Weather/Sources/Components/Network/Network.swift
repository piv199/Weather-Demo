//
//  Network.swift
//  Weather
//
//  Created by Oleksii Pyvovarov on 08.05.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import Alamofire

final class Network {
    typealias ResponseResult = Result<Response, Error>
    typealias Completion = (ResponseResult) -> Void
    typealias Method = Alamofire.HTTPMethod
    typealias Headers = Alamofire.HTTPHeaders
    typealias Header = Alamofire.HTTPHeader

    // MARK: - Properties

    private let session: Session
    private let baseURL: URL?

    // MARK: - Lifecycle

    init(baseURL: URL? = nil, session: Session = .default) {
        self.baseURL = baseURL
        self.session = session

    }

    // MARK: - Actions

    func request(_ target: RequestConvertible, qos: DispatchQoS.QoSClass = .default,
                 completion: @escaping Completion) -> Cancellable {
        let token = CancellableToken()
        do {
            let request = try URLRequest(target, baseURL: baseURL)
            switch target.task {
            case .requestPlain, .requestParameters, .requestJSONEncodable:
                let task = session.request(request)
                    .response { response in completion(Result { try Response(response) }) }
                token.didCancel { task.cancel() }
            }

        } catch {
            completion(.failure(error))
        }
        return token;
    }
}
