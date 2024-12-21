//
//  LocalDataAssembly.swift
//  LocalDataCore
//
//  Created by 박창규 on 12/1/24.
//

import Foundation

import LocalDataCoreInterface

import Swinject
import RealmSwift

final public class LocalDataAssembly: Assembly {
    private let realm: Realm
    
    public init(realm: Realm) {
        self.realm = realm
    }
    
    public func assemble(container: Swinject.Container) {
        container.register(
            LocalDataProtocol.self
        ) { _ in LocalDataProtocolImpl(realm: self.realm) }
    }
}
