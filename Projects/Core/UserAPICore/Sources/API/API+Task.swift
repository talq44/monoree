//
//  API+Task.swift
//  API
//
//  Created by 박창규 on 2023/09/17.
//

import Foundation

import UserAPICoreInterface

import Moya

extension API {
    public var task: Task {
        switch self {
        case let .get_search_users(_, request):
            return .requestParameters(
                parameters: request.parameters(),
                encoding: URLEncoding.queryString
            )
        }
    }
}
