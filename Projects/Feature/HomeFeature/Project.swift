import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: FeatureModule.HomeFeature.name,
    settings: .Module.default,
    targets: [
        .interface(
            feature: .HomeFeature,
            dependencies: []
        ),
        .implementation(
            feature: .HomeFeature,
            dependencies: [
                .SPM.ComposableArchitecture,
                .feature(target: .HomeFeature, type: .interface),
            ]
        ),
        .demo(
            feature: .HomeFeature,
            dependencies: [
                .feature(target: .HomeFeature, type: .implementation),
            ]
        ),
    ]
)
