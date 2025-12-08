import ProjectDescription

public enum FeatureModule: String, CaseIterable {
	case AnimalQuizLabFeature
    case GamePlayFeature
    
    public var name: String {
        self.rawValue
    }
}
