//
//  VersionConfigManager.swift
//  RemoteConfigCoreInterface
//
//  Created by 박창규 on 8/27/25.
//

import Foundation

public protocol VersionConfigManager {
    func fetchVersion() throws -> any VersionDTO
}
