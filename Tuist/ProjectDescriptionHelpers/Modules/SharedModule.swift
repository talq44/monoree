import ProjectDescription

public enum SharedModule: String, CaseIterable {
    case FirebaseSPMShared
	case FoundationShared
    
    public var name: String {
        self.rawValue
    }
}
