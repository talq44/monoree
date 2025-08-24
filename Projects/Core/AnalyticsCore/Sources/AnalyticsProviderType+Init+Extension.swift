//
//  AnalyticsProviderType+Init+Extension.swift
//  AnalyticsCoreInterface
//
//  Created by 박창규 on 8/24/25.
//

import Foundation
import AnalyticsCoreInterface

extension AnalyticsProviderType {
    var provider: AnalyticsProtocol {
        switch self {
        case .firebase:
            return FirebaseProvider()
        }
    }
}
