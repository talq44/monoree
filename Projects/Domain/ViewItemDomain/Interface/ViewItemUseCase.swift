import Foundation

public protocol ViewItemUseCase {
    /// 제품 세부정보의 조회수를 측정하려면 사용자가 제품의 세부정보 화면을 볼 때마다 view_item 이벤트를 로깅합니다.
    /// - https://firebase.google.com/docs/analytics/measure-ecommerce?hl=ko#view_product
    func send(_ input: ViewItemInput)
}
