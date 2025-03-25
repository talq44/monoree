import ProjectDescription

public enum ModuleType {
    case interface
    case implementation
    case testing
    case tests
    case demo
    
    var name: String {
        switch self {
        case .interface: return "Interface"
        case .implementation: return ""
        case .tests: return "Tests"
        case .testing: return "Testing"
        case .demo: return "Demo"
        }
    }
}
