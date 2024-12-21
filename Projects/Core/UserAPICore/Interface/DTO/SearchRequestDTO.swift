//
//  SearchRequestDTO.swift
//  UserAPICoreInterface
//
//  Created by 박창규 on 11/29/24.
//

import Foundation

public struct SearchRequestDTO: Encodable {
    public let q: String
    public let per_page: Int?
    public let page: Int?
    
    public init(q: String, per_page: Int?, page: Int?) {
        self.q = q
        self.per_page = per_page
        self.page = page
    }
}
