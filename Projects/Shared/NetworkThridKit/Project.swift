import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: SharedModule.NetworkThridKit.name,
    settings: .Module.default,
    targets: [
        .implementation(
            shared: .NetworkThridKit,
            dependencies: [
                .SPM.alamofire,
                .SPM.moya,
            ]
        ),
    ]
)
