import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: SharedModule.RxThirdKit.name,
    settings: .Module.default,
    targets: [
        .implementation(
            shared: .RxThirdKit,
            dependencies: [
                .shared(target: .RxThirdKit, type: .interface),
            ]
        )
    ]
)
