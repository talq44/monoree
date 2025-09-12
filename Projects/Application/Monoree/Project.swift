import ProjectDescription
import ProjectDescriptionHelpers

let appName = "Monoree"

let targets: [Target] = [
    .target(
        name: appName,
        destinations: .iOS,
        product: .app,
        bundleId: "$(APP_BUNDLE_ID)",
        deploymentTargets: .appVersion,
        infoPlist: .extendingDefault(
            with: [
                "UILaunchStoryboardName": "LaunchScreen",
                "UISupportedInterfaceOrientations": [
                    "UIInterfaceOrientationPortrait",
                    "UIInterfaceOrientationLandscapeLeft",
                    "UIInterfaceOrientationLandscapeRight",
                ],
                "UILaunchScreen": [
                    "UIColorName": "",
                    "UIImageName": "",
                ],
            ]
        ),
        sources: ["Sources/**"],
        resources: [
            .glob(
                pattern: "Resources/**",
                excluding: [
                    "Resources/dev",
                    "Resources/GoogleService-Info-Dev.plist"
                ]
            )
        ],
        scripts: [
            .pre(
                script: """
                $SRCROOT/../../Scripts/GoogleService-Info.sh
                """,
                name: "GoogleService-Info"
            )
        ],
        dependencies: [
            // SPM
            .shared(target: .FirebaseSPMShared),
            
            
//            // Core
//            .core(target: .UserAPICore, type: .implementation),
//            // Domain
//            .domain(target: .UserGameSettingDomain, type: .implementation),
//            // Feature
//            .feature(target: .HomeFeature, type: .implementation),
//            .feature(target: .GamePlayFeature, type: .implementation),
//            .feature(target: .IntroFeature, type: .implementation),
        ]
//        + TargetDependency.SPM.allCases
//            .map { $0.targetDependency }
    ),
    .target(
        name: "\(appName)Tests",
        destinations: .iOS,
        product: .unitTests,
        bundleId: "io.tuist.\(appName)Tests",
        deploymentTargets: .appVersion,
        infoPlist: .default,
        sources: ["Tests/**"],
        dependencies: [
            .target(name: appName)
        ]
    ),
]

let schemes: [Scheme] = MonoreeScheme.allCases
    .map { .makeScheme(type: $0) }

let project = Project.module(
    name: appName,
    options: .options(
        defaultKnownRegions: ["ko"],
        developmentRegion: "ko"
    ),
    settings: .Application.default,
    targets: targets,
    schemes: schemes
)
