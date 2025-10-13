import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: SharedModule.UIKitExtensionShared.name,
    settings: .Module.default,
    targets: [
		.implementation(
			shared: .UIKitExtensionShared,
			dependencies: [ ]
		)
	]
)
