import ProjectDescription
import ProjectDescriptionHelpers

//let project = Project.module(
//    name: SharedModule.FirebaseSPMShared.name,
//    settings: .Module.default,
//    targets: [
//        .implementation(
//            shared: .FirebaseSPMShared,
//            product: .framework,
//            dependencies: [
//                .SPM.firebaseCore.targetDependency,
//                .SPM.firebaseAnalytics.targetDependency,
//                .SPM.firebaseCrashlytics.targetDependency,
//                .SPM.firebasePerformance.targetDependency,
//                .SPM.firebaseRemoteConfig.targetDependency,
//            ]
//        ),
//    ]
//)

let project = Project(
    name: SharedModule.FirebaseSPMShared.name,
    settings: .Module.default,
    targets: [
        .target(
            name: SharedModule.FirebaseSPMShared.name,
            destinations: .iOS,
            product: .framework,
            bundleId: "com.monoree.FirebaseSPMShared",
            deploymentTargets: .deploymentTargetVersion,
            infoPlist: .default,
            sources: "Sources/**",
            dependencies: [
                // Firebase
                .SPM.firebaseAnalytics.targetDependency,
                .SPM.firebaseCrashlytics.targetDependency,
                .SPM.firebaseMessaging.targetDependency,
                .SPM.firebasePerformance.targetDependency,
                .SPM.firebaseRemoteConfig.targetDependency,
            ],
            settings: .settings(base: SettingsDictionary().otherLinkerFlags(["-ObjC"]))
        )
    ]
)
