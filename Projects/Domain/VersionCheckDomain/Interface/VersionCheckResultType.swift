import Foundation

public enum VersionUpdateResult: Equatable {
    /// 유지(별도 동작 없음)
    case none
    /// 선택 업
    case optional(url: String)
    /// 필수 업
    case required(url: String)
}
