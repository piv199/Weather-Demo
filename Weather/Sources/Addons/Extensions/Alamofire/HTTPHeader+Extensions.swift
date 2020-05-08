//
//  HTTPHeader+Extensions.swift
//  Weather
//
//  Created by Oleksii Pyvovarov on 08.05.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import Alamofire

extension HTTPHeaders {
    mutating func addIfMissing(_ header: HTTPHeader) {
        guard first(where: { $0.name == header.name }) == nil else { return }
        add(header)
    }
}
