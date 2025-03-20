//
//  TimeType+Extension.swift
//  TimerFeature
//
//  Created by 박창규 on 3/20/25.
//

import Foundation

import TimerFeatureInterface

extension TimeType {
    var timeInterval: TimeInterval {
        switch self {
        case .seconds_3:
            return 3.0
        case .seconds_5:
            return 5.0
        case .seconds_10:
            return 10.0
        case .seconds(let time):
            return time
        }
    }
}
