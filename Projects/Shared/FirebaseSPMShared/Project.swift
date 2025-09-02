import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: SharedModule.FirebaseSPMShared.name,
    settings: .Module.default,
    targets: [
        .implementation(
            shared: .FirebaseSPMShared,
            dependencies: [
                .SPM.firebaseCore,
                .SPM.firebaseAnalytics,
                .SPM.firebaseCrashlytics,
                .SPM.firebasePerformance,
                .SPM.firebaseRemoteConfig,
            ]
        ),
    ]
)
