//
//  Project.swift
//  Config
//
//  Created by 박창규 on 11/28/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let appName = "Monoree"
let project = Project(
    name: appName,
    targets: [
        .target(
            name: appName,
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.\(appName)",
            deploymentTargets: .appVersion,
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen",
                    "UISupportedInterfaceOrientations": [
                        "UIInterfaceOrientationPortrait"
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
                // Core
                .core(target: .UserAPICore, type: .implementation),
                // Domain
                .domain(target: .KoreanChosungDomain, type: .implementation),
                .domain(target: .VersionCheckDomain, type: .implementation),
                // Feature
            ]
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
)
