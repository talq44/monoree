import ProjectDescription

public enum SharedModule: String, CaseIterable {
	case DesignSystem
    case FirebaseSPMShared
	case FoundationShared
    
    public var name: String {
        self.rawValue
    }
}
