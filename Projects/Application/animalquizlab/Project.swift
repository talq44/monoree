import ProjectDescription
import ProjectDescriptionHelpers

private let appName = "AnimalQuizLab"

let targets: [Target] = [
    .target(
        name: appName,
        destinations: .iOS,
        product: .app,
        bundleId: "com.monoree.animalquizlab",
        deploymentTargets: .deploymentTargetVersion,
        infoPlist: .extendingDefault(
            with: [
                "UILaunchStoryboardName": "LaunchScreen",
                "UISupportedInterfaceOrientations": [
                    "UIInterfaceOrientationPortrait",
                    "UIInterfaceOrientationLandscapeLeft",
                    "UIInterfaceOrientationLandscapeRight",
                ],
                "UIApplicationSceneManifest": .dictionary([
                    "UIApplicationSupportsMultipleScenes": .boolean(false),
                    "UISceneConfigurations": .dictionary([
                        "UIWindowSceneSessionRoleApplication": .array([
                            .dictionary([
                                "UISceneConfigurationName": .string("Default Configuration"),
                                "UISceneDelegateClassName": .string(
                                    "$(PRODUCT_MODULE_NAME).SceneDelegate")
                            ])
                        ])
                    ])
                ]),
            ]
        ),
        sources: ["Sources/**"],
        resources: ["Resources/**"],
        dependencies: [
//            .feature(target: .AnimalQuizLabFeature, type: .implementation),
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
        bundleId: "com.monoree.\(appName).Tests",
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
