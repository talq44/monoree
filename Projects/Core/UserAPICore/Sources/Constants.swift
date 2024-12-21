//
//  Constants.swift
//  UserAPICoreInterface
//
//  Created by 박창규 on 11/23/24.
//

import Foundation

import SwiftDotEnv

struct Constants {
    static var baseURL: String = "https://api.github.com"
    
    static let timeoutIntervalForRequest: Double = 30
    static let timeoutIntervalForResource: Double = 30
    
    static var githubToken: String = ""
}
