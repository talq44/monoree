import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: SharedModule.FirebaseShared.name,
    settings: .Module.default,
    targets: [
		.interface(
			shared: .FirebaseShared,
			dependencies: []
		),
		.implementation(
			shared: .FirebaseShared,
			dependencies: [
				.shared(target: .FirebaseShared, type: .interface),
			]
		),
		.testing(
			shared: .FirebaseShared,
			dependencies: [
				.shared(target: .FirebaseShared, type: .interface),
			]
		),
		.tests(
			shared: .FirebaseShared,
			dependencies: [
				.shared(target: .FirebaseShared, type: .implementation),
				.shared(target: .FirebaseShared, type: .testing),
			]
		),
]
)