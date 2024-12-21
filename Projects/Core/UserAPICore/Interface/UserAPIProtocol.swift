//
//  UserAPIProtocol.swift
//  UserAPICoreInterface
//
//  Created by 박창규 on 11/29/24.
//

import Foundation

public protocol UserAPIProtocol {
    func get_search_users(
        header: SearchHeaderDTO,
        request: SearchRequestDTO
    ) async throws -> SearchResponseDTO
}
