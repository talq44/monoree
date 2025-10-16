import Foundation
import UserDefaultCoreInterface

public final class UserDefaultManagerImpl: UserDefaultManageable {
    private let defaultStore: UserDefaults
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    
    public init(
        suiteName: String? = nil,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        if
            let suiteName,
            let suiteStore = UserDefaults(suiteName: suiteName) {
            self.defaultStore = suiteStore
        } else {
            self.defaultStore = .standard
        }
        self.encoder = encoder
        self.decoder = decoder
    }
    
    public func value<T: UserDefaultTargetType>(for target: T) -> T.Value? {
        let store = storage(for: target.suiteName)
        
        if let rawValue = store.object(forKey: target.key) as? T.Value {
            return rawValue
        }
        
        guard let data = store.data(forKey: target.key) else {
            return target.defaultValue
        }
        
        do {
            return try decoder.decode(T.Value.self, from: data)
        } catch {
            store.removeObject(forKey: target.key)
            return target.defaultValue
        }
    }
    
    public func set<T: UserDefaultTargetType>(_ value: T.Value?, for target: T) {
        let store = storage(for: target.suiteName)
        
        guard let value else {
            store.removeObject(forKey: target.key)
            return
        }
        
        if let primitive = value as? AnyUserDefaultPrimitive {
            primitive.write(to: store, key: target.key)
            return
        }
        
        do {
            let data = try encoder.encode(value)
            store.set(data, forKey: target.key)
        } catch {
            store.removeObject(forKey: target.key)
        }
    }
    
    public func remove<T: UserDefaultTargetType>(_ target: T) {
        let store = storage(for: target.suiteName)
        store.removeObject(forKey: target.key)
    }
    
    public func contains<T: UserDefaultTargetType>(_ target: T) -> Bool {
        let store = storage(for: target.suiteName)
        return store.object(forKey: target.key) != nil
    }
    
    private func storage(for suiteName: String?) -> UserDefaults {
        guard
            let suiteName,
            !suiteName.isEmpty,
            let suiteStore = UserDefaults(suiteName: suiteName) else {
            return defaultStore
        }
        return suiteStore
    }
}

private protocol AnyUserDefaultPrimitive {
    func write(to store: UserDefaults, key: String)
}

extension Bool: AnyUserDefaultPrimitive {
    fileprivate func write(to store: UserDefaults, key: String) {
        store.set(self, forKey: key)
    }
}

extension Int: AnyUserDefaultPrimitive {
    fileprivate func write(to store: UserDefaults, key: String) {
        store.set(self, forKey: key)
    }
}

extension Double: AnyUserDefaultPrimitive {
    fileprivate func write(to store: UserDefaults, key: String) {
        store.set(self, forKey: key)
    }
}

extension Float: AnyUserDefaultPrimitive {
    fileprivate func write(to store: UserDefaults, key: String) {
        store.set(self, forKey: key)
    }
}

extension String: AnyUserDefaultPrimitive {
    fileprivate func write(to store: UserDefaults, key: String) {
        store.set(self, forKey: key)
    }
}

extension URL: AnyUserDefaultPrimitive {
    fileprivate func write(to store: UserDefaults, key: String) {
        store.set(self, forKey: key)
    }
}

extension Data: AnyUserDefaultPrimitive {
    fileprivate func write(to store: UserDefaults, key: String) {
        store.set(self, forKey: key)
    }
}

extension Date: AnyUserDefaultPrimitive {
    fileprivate func write(to store: UserDefaults, key: String) {
        store.set(self, forKey: key)
    }
}
