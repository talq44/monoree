import UIKit
import UIKitExtensionShared
import SnapKit
import ReactorKit
import RxSwift
import RxCocoa

struct GamePlayViewPayload {
    let answerCount: Int
    let isAutoScroll: Bool
}

final class GamePlayViewController: BaseViewController {
    private let animalNames: [String] = [
        "사자", "호랑이", "원숭이", "고양이", "개", "곰", "코끼리", "기린", "판다", "늑대",
        "여우", "토끼", "하마", "코뿔소", "치타", "하이에나", "수달", "너구리", "다람쥐", "바다사자",
        "돌고래", "상어", "물개", "바다거북", "앵무새", "독수리", "부엉이", "올빼미", "타조", "펭귄",
        "카멜레온", "이구아나", "악어", "도마뱀", "뱀", "개미핥기", "캥거루", "코알라", "라마", "알파카"
    ]

    private func randomAnimalNames(count requested: Int) -> [String] {
        let capped = max(0, min(10, requested))
        if capped == 0 { return [] }
        // Shuffle and take the first N to guarantee uniqueness
        return Array(animalNames.shuffled().prefix(capped))
    }
    
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
        
        itemView.bind(state: GameContentView.State(
            gameQuestion: .image(
                url: "https://cdn.jsdelivr.net/gh/talq44/monoree_images@main/animal/toy3D/lion.webp"
            ),
            answers: randomAnimalNames(count: payload.answerCount),
            didSelectAnswer: { row in
                print("row \(row)")
            })
        )
    }
}
