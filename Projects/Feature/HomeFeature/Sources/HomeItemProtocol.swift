//
//  HomeItemProtocol.swift
//  HomeFeatureDemoApp
//
//  Created by 박창규 on 8/28/25.
//

import Foundation

protocol HomeItemProtocol: Identifiable, Hashable {
    var id: String { get }
    var rank: Int? { get set }
    var title: String { get set }
    var subtitle: String { get set }
    var emojiIcon: String { get set }
}
