//
//  TargetDependency+SPM+Template.swift
//  Manifests
//
//  Created by 박창규 on 11/20/24.
//

import ProjectDescription

extension TargetDependency {
    public enum SPM: CaseIterable {
        case alamofire
        case composableArchitecture
        case firebaseAnalytics
        case firebaseCore
        case firebaseRemoteConfig
        case firebaseCrashlytics
        case firebaseMessaging
        case firebasePerformance
        case kingfisher
        case moya
        case swifterSwift
        
        public var targetDependency: TargetDependency {
            switch self {
            case .alamofire:
                return .external(
                    name: "Alamofire"
                )
            case .composableArchitecture:
                return .external(
                    name: "ComposableArchitecture"
                )
            case .firebaseAnalytics:
                return .external(
                    name: "FirebaseAnalytics"
                )
            case .firebaseCore:
                return .external(
                    name: "FirebaseCore"
                )
            case .firebaseRemoteConfig:
                return .external(
                    name: "FirebaseRemoteConfig"
                )
            case .firebaseCrashlytics:
                return .external(
                    name: "FirebaseCrashlytics"
                )
            case .firebaseMessaging:
                return .external(
                    name: "FirebaseMessaging"
                )
            case .firebasePerformance:
                return .external(
                    name: "FirebasePerformance"
                )
            case .kingfisher:
                return .external(
                    name: "Kingfisher"
                )
            case .moya:
                return .external(
                    name: "Moya"
                )
            case .swifterSwift:
                return .external(
                    name: "SwifterSwift"
                )
            }
        }
    }
}
