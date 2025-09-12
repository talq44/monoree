import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: SharedModule.NetworkThirdKit.name,
    settings: .Module.default,
    targets: [
        .implementation(
            shared: .NetworkThirdKit,
            dependencies: [
                .SPM.alamofire.targetDependency,
                .SPM.moya.targetDependency,
            ]
        ),
    ]
)
