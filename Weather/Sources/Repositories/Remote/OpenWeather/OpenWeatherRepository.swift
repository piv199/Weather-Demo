//
//  OpenWeatherRepository.swift
//  Weather
//
//  Created by Oleksii Pyvovarov on 08.05.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import Alamofire
import Combine

enum OpenWeather {
    final class Repository {
        // MARK: - Properties

        private let apiKey: String
        private let network: Network

        private var cancellables = Set<AnyCancellable>()

        // MARK: - Lifecycle

        init(network: Network, apiKey: String) {
            self.apiKey = apiKey
            self.network = network
        }

        // MARK: -

        func forecast() {
            let request = Network.Request(
                baseURL: URL(string: "https://api.openweathermap.org"),
                path: "data/2.5/forecast/daily",
                method: .get,
                task: .requestParameters(["q": "Dnipro", "cnt": 10, "appid": apiKey], encoding: URLEncoding.default),
                headers: .default
            )
            network.requestPublisher(request)
                .map { $0.data.flatMap{ String(data: $0, encoding: .utf8) } }
                .replaceNil(with: "")
                .sink(receiveCompletion: { (completion) in
                    print("Received completion \(completion).")
                }, receiveValue: { value in
                    print("Received value \(value)")
                })
                .store(in: &cancellables)
        }
    }
}
