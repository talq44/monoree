//
//  API+Header.swift
//  API
//
//  Created by 박창규 on 2023/09/17.
//

import Foundation

extension API {
    public var headers: [String : String]? {
        switch self {
        case let .get_search_users(header, _):
            return [
                "Accept": "application/vnd.github+json",
                "Authorization": "Bearer \(header.token)"
            ]
        }
    }
}
