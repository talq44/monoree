import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
  name: SharedModule.FirebaseShared.name,
  settings: .Module.default,
  targets: [
    .interface(
      shared: .FirebaseShared,
      dependencies: [
        .SPM.firebaseAuth,
        .SPM.firebaseAnalytics,
        .SPM.firebaseCrashlytics,
        .SPM.firebaseFirestore,
        .SPM.firebaseMessaging,
        .SPM.firebasePerformance,
        .SPM.firebaseRemoteConfig,
      ]
    ),
    .implementation(
      shared: .FirebaseShared,
      dependencies: [
        .shared(target: .FirebaseShared, type: .interface)
      ]
    ),
  ]
)
