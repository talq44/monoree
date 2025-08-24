//
//  VersionDTOImpl.swift
//  RemoteConfigCore
//
//  Created by 박창규 on 8/24/25.
//

import Foundation
import RemoteConfigCoreInterface

struct VersionDTOImpl: VersionDTO {
    var minVersion: String
    var maxVersion: String
}
