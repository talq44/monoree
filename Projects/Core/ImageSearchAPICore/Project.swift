import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: CoreModule.ImageSearchAPICore.name,
    settings: .Module.default,
    targets: [
        .interface(
            core: .ImageSearchAPICore,
            dependencies: []
        ),
        .implementation(
            core: .ImageSearchAPICore,
            dependencies: [
                .core(target: .ImageSearchAPICore, type: .interface),
                .core(target: .RestAPIErrorCore, type: .interface),
                .SPM.alamofire,
                .SPM.moya,
                .SPM.swinject,
            ]
        ),
        .testing(
            core: .ImageSearchAPICore,
            dependencies: [
                .core(target: .ImageSearchAPICore, type: .interface),
            ]
        ),
        .tests(
            core: .ImageSearchAPICore,
            dependencies: [
                .core(target: .ImageSearchAPICore, type: .implementation),
                .core(target: .ImageSearchAPICore, type: .testing),
            ]
        ),
    ]
)
