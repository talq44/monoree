import Foundation

import Combine

public protocol TimerService {
    func setTime(_ interval: TimeType)
    func start() -> AnyPublisher<Bool, Never>
    func stop()
}
