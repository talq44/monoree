import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: DomainModule.AnimalListDomain.name,
    settings: .Module.default,
    targets: [
		.interface(
			domain: .AnimalListDomain,
			dependencies: []
		),
		.implementation(
			domain: .AnimalListDomain,
			dependencies: [
				.domain(target: .AnimalListDomain, type: .interface),
			]
		),
		.testing(
			domain: .AnimalListDomain,
			dependencies: [
				.domain(target: .AnimalListDomain, type: .interface),
			]
		),
		.tests(
			domain: .AnimalListDomain,
			dependencies: [
				.domain(target: .AnimalListDomain, type: .implementation),
				.domain(target: .AnimalListDomain, type: .testing),
			]
		),
	]
)