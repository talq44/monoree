import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: SharedModule.RxThirdKit.name,
    settings: .Module.default,
    targets: [
        .implementation(
            shared: .RxThirdKit,
            dependencies: [
                .SPM.reactorKit.targetDependency,
                .SPM.rxSwift.targetDependency,
                .SPM.rxCocoa.targetDependency,
            ]
        )
    ]
)
