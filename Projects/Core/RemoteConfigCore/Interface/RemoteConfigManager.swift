//
//  RemoteConfigManager.swift
//  RemoteConfigCore
//
//  Created by 박창규 on 8/24/25.
//

import Foundation

public protocol RemoteConfigManager: VersionConfigManager, GameConfigManager {
    func fetch() async throws -> Void
}
