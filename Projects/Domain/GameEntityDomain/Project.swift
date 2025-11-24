import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: DomainModule.GameEntityDomain.name,
    settings: .Module.default,
    targets: [
		.interface(
			domain: .GameEntityDomain,
			dependencies: []
		)
	]
)
