import Foundation
import SwiftUI

public protocol GamePlayService {
    
    init(
        gameTypes: [GamePlayType],
        timeInterval: TimeInterval,
        teamName: String?
    )
    
    func view() -> AnyView
}
