import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: CoreModule.RemoteConfigCore.name,
    settings: .Module.default,
    targets: [
		.interface(
			core: .RemoteConfigCore,
			dependencies: []
		),
		.implementation(
			core: .RemoteConfigCore,
			dependencies: [
				.core(target: .RemoteConfigCore, type: .interface),
			]
		),
		.testing(
			core: .RemoteConfigCore,
			dependencies: [
				.core(target: .RemoteConfigCore, type: .interface),
			]
		),
		.tests(
			core: .RemoteConfigCore,
			dependencies: [
				.core(target: .RemoteConfigCore, type: .implementation),
				.core(target: .RemoteConfigCore, type: .testing),
			]
		),
]
)