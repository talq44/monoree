import Foundation
import Combine

import RxSwift

public extension Publisher {
    func asObservable() -> Observable<Output> {
        Observable.create { observer in
            let cancellable = self.sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                },
                receiveValue: { value in
                    observer.onNext(value)
                }
            )
            return Disposables.create {
                cancellable.cancel()
            }
        }
    }
}
