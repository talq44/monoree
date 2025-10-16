import Testing
import Foundation
@testable import UserDefaultCore
import UserDefaultCoreInterface

struct UserDefaultManagerTests {
    private let primarySuite = "com.monoree.tests.user-default-manager.primary"
    private let secondarySuite = "com.monoree.tests.user-default-manager.secondary"

    private func resetSuite(_ name: String) {
        UserDefaults.standard.removePersistentDomain(forName: name)
        UserDefaults(suiteName: name)?.removePersistentDomain(forName: name)
    }

    @Test("Primitive value round trip with default fallback")
    func primitiveRoundTrip() {
        resetSuite(primarySuite)
        let manager: UserDefaultManageable = UserDefaultManagerImpl(suiteName: primarySuite)

        let onboardingKey = UserDefaultKey<Bool>(
            "onboarding.seen",
            defaultValue: false
        )

        #expect(manager.contains(onboardingKey) == false)
        #expect(manager.value(for: onboardingKey) == false)

        manager.set(true, for: onboardingKey)
        #expect(manager.contains(onboardingKey) == true)
        #expect(manager.value(for: onboardingKey) == true)

        manager.set(nil, for: onboardingKey)
        #expect(manager.contains(onboardingKey) == false)
        #expect(manager.value(for: onboardingKey) == false)
    }

    @Test("Codable value stored in dedicated suite")
    func codableRoundTrip() throws {
        resetSuite(primarySuite)
        resetSuite(secondarySuite)

        let manager = UserDefaultManagerImpl(suiteName: primarySuite)
        let profileKey = UserDefaultKey<PlayerProfile>(
            "profile.last",
            suiteName: secondarySuite
        )

        #expect(manager.value(for: profileKey) == nil)

        let saved = PlayerProfile(
            name: "Finn",
            level: 7,
            badges: ["explorer", "puzzle-master"]
        )

        manager.set(saved, for: profileKey)
        let restored = manager.value(for: profileKey)

        #expect(restored == saved)
        #expect(UserDefaults(suiteName: primarySuite)?.data(forKey: profileKey.key) == nil)
        #expect(UserDefaults(suiteName: secondarySuite)?.data(forKey: profileKey.key) != nil)
    }
}

private struct PlayerProfile: Codable, Equatable {
    let name: String
    let level: Int
    let badges: [String]
}
