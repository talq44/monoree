import ProjectDescription
import ProjectDescriptionHelpers

public let appName = "Monoree"

let targets: [Target] = [
    .target(
        name: appName,
        destinations: .iOS,
        product: .app,
        bundleId: "$(APP_BUNDLE_ID)",
        deploymentTargets: .deploymentTargetVersion,
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
        resources: ["Resources/**"],
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
        ],
        settings: .settings(
            base: SettingsDictionary()
                .otherLinkerFlags(["-ObjC"])
                .debugInformationFormat(.dwarfWithDsym)
        )
    ),
    .target(
        name: "\(appName)Tests",
        destinations: .iOS,
        product: .unitTests,
        bundleId: "io.tuist.\(appName).Tests",
        deploymentTargets: .deploymentTargetVersion,
        infoPlist: .default,
        sources: ["Tests/**"],
        dependencies: [
            .target(name: appName)
        ]
    ),
]

let schemes: [Scheme] = SchemeTemplate.allCases
    .map { .makeScheme(type: $0, appName: appName) }

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
