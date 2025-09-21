import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: CoreModule.AdMobCore.name,
    settings: .Module.default,
    targets: [
		.interface(
			core: .AdMobCore,
			dependencies: []
		),
		.implementation(
			core: .AdMobCore,
			dependencies: [
				.core(target: .AdMobCore, type: .interface),
			]
		),
		.testing(
			core: .AdMobCore,
			dependencies: [
				.core(target: .AdMobCore, type: .interface),
			]
		),
		.tests(
			core: .AdMobCore,
			dependencies: [
				.core(target: .AdMobCore, type: .implementation),
				.core(target: .AdMobCore, type: .testing),
			]
		),
	]
)