import ProjectDescription

public enum SharedModule: String, CaseIterable {
	case DesignSystem
    case FirebaseSPMShared
	case FoundationShared
    case ReactiveXShared
    
    public var name: String {
        self.rawValue
    }
}
