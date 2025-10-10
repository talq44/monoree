import ProjectDescription
import ProjectDescriptionHelpers

public let appName = "AnimalQuizLab"

let targets: [Target] = [
    .application(
        name: appName,
        spec: TargetSpec(
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
            )
        ),
        dependencies: []
    ),
    .applicationTests(
        name: appName,
        dependencies: [
            .target(name: appName)
        ]
    )
]

let project = Project.module(
    name: appName,
    options: .options(
        defaultKnownRegions: ["ko"],
        developmentRegion: "ko"
    ),
    settings: .Application.default,
    targets: targets
)
