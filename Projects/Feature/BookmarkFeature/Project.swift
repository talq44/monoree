import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: FeatureModule.BookmarkFeature.name,
    settings: .Module.default,
    targets: [
        .interface(
            feature: .BookmarkFeature,
            dependencies: []
        ),
        .implementation(
            feature: .BookmarkFeature,
            dependencies: [
                .SPM.snapKit,
                .SPM.fakery,
                .feature(target: .BookmarkFeature, type: .interface),
                .domain(target: .BookmarkUpdateDomain, type: .interface),
                .domain(target: .BookmarkListDomain, type: .interface),
                .shared(target: .ReactiveXShared),
                .shared(target: .DesignSystem),
            ]
        ),
        .testing(
            feature: .BookmarkFeature,
            dependencies: [
                .feature(target: .BookmarkFeature, type: .interface),
            ]
        ),
        .tests(
            feature: .BookmarkFeature,
            dependencies: [
                .feature(target: .BookmarkFeature, type: .implementation),
                .feature(target: .BookmarkFeature, type: .testing),
            ]
        ),
        .preview(
            feature: .BookmarkFeature,
            dependencies: [
                .SPM.snapKit,
                .SPM.fakery,
                .feature(target: .BookmarkFeature, type: .interface),
                .domain(target: .BookmarkUpdateDomain, type: .interface),
                .domain(target: .BookmarkListDomain, type: .interface),
                .shared(target: .ReactiveXShared),
                .shared(target: .DesignSystem),
            ]
        ),
        .demo(
            feature: .BookmarkFeature,
            dependencies: [
                .SPM.swinject,
                .SPM.realm,
                .SPM.realmSwift,
                .SPM.fakery,
                .feature(target: .BookmarkFeature, type: .implementation),
                .feature(target: .BookmarkFeature, type: .testing),
                .domain(target: .BookmarkUpdateDomain, type: .implementation),
                .domain(target: .BookmarkListDomain, type: .implementation),
                .core(target: .LocalDataCore, type: .implementation),
            ]
        ),
    ]
)
