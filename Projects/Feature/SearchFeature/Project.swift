import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: FeatureModule.SearchFeature.name,
    settings: .Module.default,
    targets: [
        .interface(
            feature: .SearchFeature,
            dependencies: []
        ),
        .implementation(
            feature: .SearchFeature,
            dependencies: [
                .SPM.snapKit,
                .SPM.fakery,
                .feature(target: .SearchFeature, type: .interface),
                .domain(target: .SearchListDomain, type: .interface),
                .domain(target: .BookmarkUpdateDomain, type: .interface),
                .domain(target: .BookmarkListDomain, type: .interface),
                .shared(target: .ReactiveXShared),
                .shared(target: .DesignSystem),
            ]
        ),
        .testing(
            feature: .SearchFeature,
            dependencies: [
                .feature(target: .SearchFeature, type: .interface),
            ]
        ),
        .tests(
            feature: .SearchFeature,
            dependencies: [
                .feature(target: .SearchFeature, type: .implementation),
                .feature(target: .SearchFeature, type: .testing),
            ]
        ),
        .demo(
            feature: .SearchFeature,
            dependencies: [
                .SPM.swinject,
                .SPM.realm,
                .SPM.realmSwift,
                .feature(target: .SearchFeature, type: .implementation),
                .feature(target: .SearchFeature, type: .testing),
                .domain(target: .SearchListDomain, type: .implementation),
                .domain(target: .BookmarkUpdateDomain, type: .implementation),
                .domain(target: .BookmarkListDomain, type: .implementation),
                .core(target: .UserAPICore, type: .implementation),
                .core(target: .LocalDataCore, type: .implementation),
                .core(target: .AuthCore, type: .implementation),
            ]
        ),
        .preview(
            feature: .SearchFeature,
            dependencies: [
                .SPM.snapKit,
                .SPM.fakery,
                .feature(target: .SearchFeature, type: .interface),
                .domain(target: .SearchListDomain, type: .interface),
                .domain(target: .BookmarkUpdateDomain, type: .interface),
                .domain(target: .BookmarkListDomain, type: .interface),
                .shared(target: .ReactiveXShared),
                .shared(target: .DesignSystem),
            ]
        ),
    ]
)
