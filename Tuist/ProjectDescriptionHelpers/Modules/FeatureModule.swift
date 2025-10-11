import ProjectDescription

public enum FeatureModule: String, CaseIterable {
	case AnimalQuizLabFeature
    case GamePlayFeature
    case HomeFeature
	case IntroFeature
    case TimerFeature
    
    public var name: String {
        self.rawValue
    }
}
