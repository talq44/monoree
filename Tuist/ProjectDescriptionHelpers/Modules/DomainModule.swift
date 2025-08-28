import ProjectDescription

public enum DomainModule: String, CaseIterable {
    case KoreanChosungDomain
    case VersionCheckDomain
    
    public var name: String {
        self.rawValue
    }
}
