import Foundation

import Combine

public protocol TimerInterface {
    func setTime(_ interval: TimeType)
    func start() -> AnyPublisher<Bool, Never>
    func stop()
}
