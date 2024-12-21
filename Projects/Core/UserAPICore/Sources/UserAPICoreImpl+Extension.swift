//
//  UserAPICoreImpl+Extension.swift
//  UserAPICoreInterface
//
//  Created by 박창규 on 11/23/24.
//

import Foundation

import UserAPICoreInterface

extension UserAPICoreImpl: UserAPICoreInterface.UserAPIProtocol {
    public func get_search_users(
        header: SearchHeaderDTO,
        request: SearchRequestDTO
    ) async throws -> SearchResponseDTO {
        return try await self.requestJson(
            .get_search_users(header: header, request: request),
            type: SearchResponseDTO.self
        )
    }
}
