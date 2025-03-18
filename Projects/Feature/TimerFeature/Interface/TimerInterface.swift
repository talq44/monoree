import Foundation

import Combine

public protocol TimerInterface {
    func setTime(_ interval: StaticTimeInterval)
    func start() -> AnyPublisher<Bool, Never>
    func stop()
}
