//
//  SearchResponseDTO.swift
//  UserAPICoreInterface
//
//  Created by 박창규 on 11/29/24.
//

import Foundation

public struct SearchResponseDTO: Decodable {
    public let total_count: Int
    public let items: [SearchResponseItemDTO]
}
