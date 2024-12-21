//
//  API+Method.swift
//  API
//
//  Created by 박창규 on 2023/09/17.
//

import Foundation

import Moya

extension API {
    public var method: Moya.Method {
        switch self {
        case .get_search_users:
            return .get
        }
    }
}
