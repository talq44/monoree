# Project Overview

## Purpose
- 이 프로젝트는 놀이들을 제공하는 iOS 애플리케이션입니다.

## Tech Stack
- Dependency Manager: Tuist, Swift Package Manager
- Architecture: SwiftUI를 채택한 프로젝트는 TCA를, UIKit을 채택한 프로젝트는 ReactorKit 을 사용합니다.
- UI Framework: Application마다, UIKit, SwiftUI 다르게 적용되어 있습니다.
- Networking: Moya, Alamofire를 사용하고 있습니다.
- CI/CD: CircleCI, GitHub Actions

## Code Style
- Swift 기본적인 형식을 따릅니다.

# Dependency Management

Tuist와 SPM을 사용하여 의존성을 관리합니다. 새로운 의존성을 추가할 때는 다음 절차를 따릅니다.

1.  `Tuist/Package.swift` 파일에 새로운 SPM 패키지를 추가합니다.
2.  `Tuist/ProjectDescriptionHelpers/TargetDependency/TargetDependency+SPM+Template.swift` 파일의 `SPM` enum에 새로운 의존성을 추가하고, `targetDependency` 속성에 해당 케이스를 구현합니다.
3.  `Project.swift` 파일에서 `.spm(.yourDependency)` 형태로 의존성을 추가합니다.
4.  마지막으로 `tuist install` 및 `tuist generate` 명령을 실행합니다.

# Build and Test Commands

- Tuist project generation: `tuist generate`
- Fetch dependencies: `tuist install`
- Build project: `xcodebuild build -scheme Monoree -workspace Monoree.xcworkspace`
- Run tests: `xcodebuild test -scheme Monoree -workspace Monoree.xcworkspace -destination '''platform=iOS Simulator,name=iPhone 15'''`

# Module Generation

새로운 모듈은 `Scripts/GenerateModule.swift` 스크립트를 사용하여 생성합니다.

`swift run GenerateModule --name [ModuleName] --platform [ios|macos] --product [framework|staticFramework|app] --type [Feature|Domain|Core|Shared]`

# Things to Avoid

- 강제 푸시(`git push --force`)는 절대로 사용하지 마세요.
