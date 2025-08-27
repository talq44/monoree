//
//  VersionDTO.swift
//  RemoteConfigCore
//
//  Created by 박창규 on 8/24/25.
//

import Foundation

public protocol VersionDTO: Decodable {
    /// 앱스토어 URL
    var appStoreUrl: String { get }
    /// 최소 지원 버전 ex) 1.0.0
    var minVersion: String { get }
    /// 최대 지원(권장/최신) 버전 ex) 1.1.0
    var maxVersion: String { get }
}
