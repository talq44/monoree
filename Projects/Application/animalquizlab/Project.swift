import ProjectDescription
import ProjectDescriptionHelpers

private let appName = "AnimalQuizLab"

let targets: [Target] = [
    .target(
        name: appName,
        destinations: .iOS,
        product: .app,
        bundleId: "com.monoree.animalquizlab",
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
        resources: ["Resources/**"],
        dependencies: [
            
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
        bundleId: "com.monoree.\(appName)Tests",
        deploymentTargets: .appVersion,
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
