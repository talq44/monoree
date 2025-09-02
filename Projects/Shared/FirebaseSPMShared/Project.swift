import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: SharedModule.FirebaseSPMShared.name,
    settings: .Module.default,
    targets: [
        .interface(
            shared: .FirebaseSPMShared,
            dependencies: []
        ),
        .implementation(
            shared: .FirebaseSPMShared,
            dependencies: [
                .shared(target: .FirebaseSPMShared, type: .interface),
                .SPM.firebaseCore,
                .SPM.firebaseAnalytics,
                .SPM.firebaseCrashlytics,
                .SPM.firebasePerformance,
                .SPM.firebaseRemoteConfig,
            ]
        ),
    ]
)
