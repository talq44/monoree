import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: FeatureModule.TimerFeature.name,
    settings: .Module.default,
    targets: [
        .interface(
            feature: .TimerFeature,
            dependencies: []
        ),
        .implementation(
            feature: .TimerFeature,
            dependencies: [
                .SPM.ComposableArchitecture,
                .feature(target: .TimerFeature, type: .interface),
            ]
        ),
        .testing(
            feature: .TimerFeature,
            dependencies: [
                .feature(target: .TimerFeature, type: .interface),
            ]
        ),
        .tests(
            feature: .TimerFeature,
            dependencies: [
                .feature(target: .TimerFeature, type: .implementation),
                .feature(target: .TimerFeature, type: .testing),
            ]
        ),
        .demo(
            feature: .TimerFeature,
            dependencies: [
                .feature(target: .TimerFeature, type: .implementation),
                .feature(target: .TimerFeature, type: .testing),
            ]
        ),
    ]
)
