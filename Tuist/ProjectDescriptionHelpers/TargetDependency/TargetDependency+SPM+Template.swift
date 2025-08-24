//
//  TargetDependency+SPM+Template.swift
//  Manifests
//
//  Created by 박창규 on 11/20/24.
//

import ProjectDescription

extension TargetDependency {
    
    public enum SPM {
        // DI
        public static let swinject: TargetDependency = .external(
            name: "Swinject"
        )
        
        // UI
        public static let snapKit: TargetDependency = .external(
            name: "SnapKit"
        )
        public static let kingfisher: TargetDependency = .external(
            name: "Kingfisher"
        )
        
        // Rx
        public static let rxSwift: TargetDependency = .external(
            name: "RxSwift"
        )
        public static let rxCocoa: TargetDependency = .external(
            name: "RxCocoa"
        )
        public static let reactorKit: TargetDependency = .external(
            name: "ReactorKit"
        )
        
        // TCA
        public static let ComposableArchitecture: TargetDependency = .external(
            name: "ComposableArchitecture"
        )
        public static let TCACoordinator: TargetDependency = .external(
            name: "TCACoordinators"
        )
        
        // Data
        public static let alamofire: TargetDependency = .external(
            name: "Alamofire"
        )
        public static let moya: TargetDependency = .external(
            name: "Moya"
        )
        
        // Firebase
        public static let firebaseAnalytics: TargetDependency = .external(
            name: "FirebaseAnalytics"
        )
        public static let firebaseRemoteConfig: TargetDependency = .external(
            name: "FirebaseRemoteConfig"
        )
        public static let firebaseCrashlytics: TargetDependency = .external(
            name: "FirebaseCrashlytics"
        )
        public static let firebaseMessaging: TargetDependency = .external(
            name: "FirebaseMessaging"
        )
        public static let firebasePerformance: TargetDependency = .external(
            name: "FirebasePerformance"
        )
        
        // Testable
        public static let fakery: TargetDependency = .external(name: "Fakery")
    }
}
