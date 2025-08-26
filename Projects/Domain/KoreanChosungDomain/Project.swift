import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: DomainModule.KoreanChosungDomain.name,
    settings: .Module.default,
    targets: [
		.interface(
			domain: .KoreanChosungDomain,
			dependencies: []
		),
		.implementation(
			domain: .KoreanChosungDomain,
			dependencies: [
				.domain(target: .KoreanChosungDomain, type: .interface),
			]
		),
		.testing(
			domain: .KoreanChosungDomain,
			dependencies: [
				.domain(target: .KoreanChosungDomain, type: .interface),
			]
		),
		.tests(
			domain: .KoreanChosungDomain,
			dependencies: [
				.domain(target: .KoreanChosungDomain, type: .implementation),
				.domain(target: .KoreanChosungDomain, type: .testing),
			]
		),
]
)