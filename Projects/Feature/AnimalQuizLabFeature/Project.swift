import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: FeatureModule.AnimalQuizLabFeature.name,
    settings: .Module.default,
    targets: [
        .interface(
            feature: .AnimalQuizLabFeature,
            dependencies: []
        ),
        .implementation(
            feature: .AnimalQuizLabFeature,
            hasResources: true,
            dependencies: [
                .shared(target: .FoundationShared),
                .shared(target: .RxThirdKit),
                .shared(target: .UIKitExtensionShared),
                .shared(target: .UIThirdKit),
                .core(target: .RemoteConfigCore, type: .interface),
                .core(target: .UserDefaultCore, type: .implementation),
                .domain(target: .GameEntityDomain, type: .interface),
                .feature(target: .AnimalQuizLabFeature, type: .interface),
            ]
        ),
        .testing(
            feature: .AnimalQuizLabFeature,
            dependencies: [
                .feature(target: .AnimalQuizLabFeature, type: .interface),
            ]
        ),
        .tests(
            feature: .AnimalQuizLabFeature,
            dependencies: [
                .feature(target: .AnimalQuizLabFeature, type: .implementation),
                .feature(target: .AnimalQuizLabFeature, type: .testing),
            ]
        ),
        .demo(
            feature: .AnimalQuizLabFeature,
            dependencies: [
                .domain(target: .AnimalListDomain, type: .implementation),
                .feature(target: .AnimalQuizLabFeature, type: .implementation),
                .feature(target: .AnimalQuizLabFeature, type: .testing),
            ]
        ),
    ]
)
