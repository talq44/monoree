//
//  LocalDataAssembly.swift
//  LocalDataCore
//
//  Created by 박창규 on 12/1/24.
//

import Foundation

import LocalDataCoreInterface

import Swinject

final public class LocalDataAssembly: Assembly {
    
    public init() { }
    
    public func assemble(container: Swinject.Container) {
        container.register(
            LocalDataProtocol.self
        ) { _ in LocalDataProtocolImpl() }
    }
}
