//
//  SearchListInputImpl.swift
//  SearchFeature
//
//  Created by 박창규 on 12/1/24.
//

import Foundation

import SearchListDomainInterface

struct SearchListInputImpl: SearchListInput {
    var query: String
    var isMore: Bool
}
