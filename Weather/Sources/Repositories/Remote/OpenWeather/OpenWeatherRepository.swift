//
//  OpenWeatherRepository.swift
//  Weather
//
//  Created by Oleksii Pyvovarov on 08.05.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

enum OpenWeather {
    final class Repository {
        // MARK: - Properties

        private let apiKey: String

        // MARK: - Lifecycle

        init(apiKey: String) {
            self.apiKey = apiKey
        }

        // MARK: -

        private(set) lazy var forecast = ForecastRepository()
    }

    final class ForecastRepository {

    }
}
