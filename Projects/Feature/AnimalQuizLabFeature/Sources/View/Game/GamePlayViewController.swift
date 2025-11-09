import UIKit
import UIKitExtensionShared
import SnapKit
import ReactorKit
import RxSwift
import RxCocoa

final class GamePlayViewController: BaseViewController {
    private let itemView = GameContentView(style: .image)
    
    private let payload: GamePlayViewPayload
    
    init(payload: GamePlayViewPayload) {
        self.payload = payload
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(itemView)
        
        itemView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide).inset(Spacing.m)
        }
        
//        itemView.bind(state: GameContentView.State(
//            type: payload.type,
//            gameQuestion: "lion",
//            answers: randomAnimalNames(count: payload.answerCount, type: payload.type),
//            didSelectAnswer: { row in
//                print("row \(row)")
//            })
//        )
    }
}
