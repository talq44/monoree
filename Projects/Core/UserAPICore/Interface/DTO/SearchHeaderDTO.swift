//
//  SearchHeaderDTO.swift
//  UserAPICoreInterface
//
//  Created by 박창규 on 11/29/24.
//

import Foundation

public struct SearchHeaderDTO {
    public let token: String
    
    public init(token: String) {
        self.token = token
    }
}
