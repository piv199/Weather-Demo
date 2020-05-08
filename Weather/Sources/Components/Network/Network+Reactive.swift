//
//  Network+Reactive.swift
//  Weather
//
//  Created by Oleksii Pyvovarov on 08.05.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import Combine

extension Network {
    func requestPublisher(_ target: RequestConvertible, qos: DispatchQoS.QoSClass = .default)
        -> Publishers.NetworkRequestPublisher {
        return .init(network: self, requestTarget: target, qos: qos)
    }
}

extension Publishers {
    struct NetworkRequestPublisher: Publisher {
        typealias Output = Network.Response
        typealias Failure = Error

        // MARK: - Properties

        let network: Network
        let requestTarget: RequestConvertible
        let qos: DispatchQoS.QoSClass

        // MARK: - Publisher

        func receive<S: Subscriber>(subscriber: S) where Failure == S.Failure, Output == S.Input {
            let subscription = NetworkRequestSubscription(network: network, requestTarget: requestTarget, qos: qos,
                                                          subscriber: subscriber)
            subscriber.receive(subscription: subscription)
        }
    }

    private class NetworkRequestSubscription<S: Subscriber>: Subscription
        where S.Input == Network.Response, S.Failure == Error {

        // MARK: - Properties

        private let cancellable: Cancellable

        // MARK: - Lifecycle

        init(network: Network, requestTarget: RequestConvertible, qos: DispatchQoS.QoSClass, subscriber: S) {
            cancellable = network.request(requestTarget, qos: qos, completion: { response in
                switch response {
                case let .success(response):
                    _ = subscriber.receive(response)
                    subscriber.receive(completion: .finished)
                case let .failure(error):
                    subscriber.receive(completion: .failure(error))
                }
            })
        }

        // MARK: - Subscription

        func request(_ demand: Subscribers.Demand) {}

        func cancel() {
            cancellable.cancel()
        }
    }
}
