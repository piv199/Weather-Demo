//
//  ViewController.swift
//  Weather
//
//  Created by Oleksii Pyvovarov on 08.05.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var repository = OpenWeather.Repository(network: Network(), apiKey: "c6f46596f01047b0ab32b8ac5cd91019")

    override func viewDidLoad() {
        super.viewDidLoad()

        repository.forecast()
    }

}
