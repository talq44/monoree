import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: CoreModule.RestAPIErrorCore.name,
    settings: .Module.default,
    targets: [
		.interface(
			core: .RestAPIErrorCore,
			dependencies: []
		),
		.implementation(
			core: .RestAPIErrorCore,
			dependencies: [
				.core(target: .RestAPIErrorCore, type: .interface),
			]
		),
		.testing(
			core: .RestAPIErrorCore,
			dependencies: [
				.core(target: .RestAPIErrorCore, type: .interface),
			]
		),
		.tests(
			core: .RestAPIErrorCore,
			dependencies: [
				.core(target: .RestAPIErrorCore, type: .implementation),
				.core(target: .RestAPIErrorCore, type: .testing),
			]
		),
]
)