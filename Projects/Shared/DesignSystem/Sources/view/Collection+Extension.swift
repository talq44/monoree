//
//  Collection+Extension.swift
//  DesignSystem
//
//  Created by 박창규 on 11/30/24.
//

import Foundation

// TODO: shared Foundation으로 위치 이동 필요
extension Collection {
    /// 크래쉬 없이 안전하게 배열 조회
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
