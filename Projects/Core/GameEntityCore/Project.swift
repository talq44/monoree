import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: CoreModule.GameEntityCore.name,
    settings: .Module.default,
    targets: [
		.interface(
			core: .GameEntityCore,
			dependencies: []
		)
	]
)
