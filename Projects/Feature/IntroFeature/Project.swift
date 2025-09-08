import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: FeatureModule.IntroFeature.name,
    settings: .Module.default,
    targets: [
        .interface(
            feature: .IntroFeature,
            dependencies: []
        ),
        .implementation(
            feature: .IntroFeature,
            dependencies: [
                // SPM
                .SPM.ComposableArchitecture,
                // domain
                .domain(target: .VersionCheckDomain, type: .interface),
                // feature
                .feature(target: .IntroFeature, type: .interface),
            ]
        ),
        .testing(
            feature: .IntroFeature,
            dependencies: [
                .domain(target: .VersionCheckDomain, type: .interface),
                .feature(target: .IntroFeature, type: .interface),
            ]
        ),
        .tests(
            feature: .IntroFeature,
            dependencies: [
                .feature(target: .IntroFeature, type: .implementation),
                .feature(target: .IntroFeature, type: .testing),
            ]
        ),
        .demo(
            feature: .IntroFeature,
            dependencies: [
                .feature(target: .IntroFeature, type: .implementation),
                .feature(target: .IntroFeature, type: .testing),
            ]
        ),
    ]
)
