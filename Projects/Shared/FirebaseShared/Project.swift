import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: SharedModule.FirebaseShared.name,
    settings: .Module.default,
    targets: [
        .interface(
            shared: .FirebaseShared,
            dependencies: []
        ),
        .implementation(
            shared: .FirebaseShared,
            dependencies: [
                .shared(target: .FirebaseShared, type: .interface),
                .SPM.firebaseAnalytics,
                .SPM.firebaseCore,
                .SPM.firebaseCrashlytics,
                .SPM.firebaseMessaging,
                .SPM.firebasePerformance,
                .SPM.firebaseRemoteConfig,
            ]
        ),
    ]
)
