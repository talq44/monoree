import Foundation

public protocol GameConfigDTO: Decodable {
    var gamePlaysPerAd: Int { get }
    /// 문제 갯수 (3, 5, 10, 20)
    var questionCount: Int? { get }
    /// 문제 당 시간(1초, 3초, 5초, 10초, 제한없음)
    var timePerQuestion: Int? { get }
    /// 전체 문제 목록의 갯수
    var teamCount: Int? { get }
}
