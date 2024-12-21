//
//  SearchResponseItemDTO.swift
//  UserAPICoreInterface
//
//  Created by 박창규 on 11/29/24.
//

import Foundation

public struct SearchResponseItemDTO: Decodable {
    public let login: String
    public let id: Int
    public let nodeId: String?
    public let avatar_url: String
    public let gravatarId: String?
}
