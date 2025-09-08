import ProjectDescription

public enum FeatureModule: String, CaseIterable {
	case IntroFeature
	case HomeFeature
    case GamePlayFeature
    case TimerFeature
    
    public var name: String {
        self.rawValue
    }
}
