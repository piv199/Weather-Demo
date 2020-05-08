//
//  Network+Task.swift
//  Weather
//
//  Created by Oleksii Pyvovarov on 08.05.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import Alamofire

extension Network {
    enum Task {
        /// A request with no additional data.
        case requestPlain

        /// A request body set with `Encodable` type and `JSONDecoder`
        case requestJSONEncodable(Encodable, encoder: JSONEncoder = JSONEncoder())

        /// A requests body set with encoded parameters.
        case requestParameters([String: Any], encoding: ParameterEncoding = JSONEncoding.default)
    }
}
