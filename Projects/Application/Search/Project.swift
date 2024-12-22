//
//  Project.swift
//  Config
//
//  Created by 박창규 on 11/28/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let appName = "Monory"
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
                .SPM.fakery,
                .SPM.swinject,
                .SPM.realm,
                .SPM.realmSwift,
                .feature(target: .SearchFeature, type: .implementation),
                .feature(target: .BookmarkFeature, type: .implementation),
                .feature(target: .SearchFeature, type: .interface),
                .feature(target: .BookmarkFeature, type: .interface),
                .domain(target: .SearchListDomain, type: .implementation),
                .domain(target: .BookmarkUpdateDomain, type: .implementation),
                .domain(target: .BookmarkListDomain, type: .implementation),
                .core(target: .UserAPICore, type: .implementation),
                .core(target: .LocalDataCore, type: .implementation),
                .core(target: .AuthCore, type: .implementation),
                .shared(target: .FoundationShared),
                .shared(target: .DesignSystem),
                .shared(target: .ReactiveXShared),
            ]
        ),
        .target(
            name: "\(appName)Tests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.\(appName)Tests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: appName)]
        ),
    ]
)
