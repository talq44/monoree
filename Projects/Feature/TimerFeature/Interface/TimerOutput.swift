import SwiftUI

public struct TimerOutput {
//    public let service: TimerService
    public let view: AnyView
    
    public init(view: AnyView) {
        self.view = view
    }
}
