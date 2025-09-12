import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: SharedModule.FirebaseSPMShared.name,
    settings: .Module.default,
    targets: [
        .implementation(
            shared: .FirebaseSPMShared,
            dependencies: [
                .SPM.firebaseCore.targetDependency,
                .SPM.firebaseAnalytics.targetDependency,
                .SPM.firebaseCrashlytics.targetDependency,
                .SPM.firebasePerformance.targetDependency,
                .SPM.firebaseRemoteConfig.targetDependency,
            ]
        ),
    ]
)
