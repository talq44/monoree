import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: CoreModule.UserAPICore.name,
    settings: .Module.default,
    targets: [
        .interface(
            core: .UserAPICore,
            dependencies: []
        ),
        .implementation(
            core: .UserAPICore,
            dependencies: [
                .core(target: .UserAPICore, type: .interface),
                .shared(target: .FoundationShared),
                .SPM.alamofire,
                .SPM.moya,
            ]
        ),
    ]
)
