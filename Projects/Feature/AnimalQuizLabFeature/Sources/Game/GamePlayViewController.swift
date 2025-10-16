import UIKit
import UIKitExtensionShared
import SnapKit
import ReactorKit
import RxSwift
import RxCocoa

struct GamePlayViewPayload {
    
}

final class GamePlayViewController: BaseViewController {
    private let itemView = GameContentView(style: .image, answer: .answer4)
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(itemView)
        
        itemView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide).inset(Spacing.m)
        }
        
        itemView.bind(state: GameContentView.State(
            gameQuestion: .image(
                url: "https://cdn.jsdelivr.net/gh/talq44/monoree_images@main/animal/toy3D/lion.webp"
            ),
            answers: ["사자", "호랑이", "까마귀", "토끼"],
            didSelectAnswer: { row in
                print("row")
            })
        )
    }
}
