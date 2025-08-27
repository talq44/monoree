import Testing

@testable import VersionCheckDomain
@testable import VersionCheckDomainTesting

struct VersionCheckDomainTest {

    @Test("데이터 미 수신시 별도 동작 없음") func remoteConfigError() {
        // given
        let remoteConfig = MockVersionConfigManager()
        let usecase = VersionCheckUsecaseImpl(remoteVersionConfig: remoteConfig)
        
        // when
        remoteConfig.setup(testCase: .error)
        let result = usecase.checkVersion("2.0.0")
        
        // then
        #expect(result == .none)
    }
    
    @Test("min 1.0.0 max 2.0.0 케이스 망라") func min또는max그어딘가() {
        // given
        let remoteConfig = MockVersionConfigManager()
        let usecase = VersionCheckUsecaseImpl(remoteVersionConfig: remoteConfig)
        let url = ""
        
        // when
        remoteConfig.setup(testCase: .normal(appStoreUrl: url, minVersion: "1.0.0", maxVersion: "2.0.0"))
        
        // then
        #expect(usecase.checkVersion("0.9.0") == .required(url: url))
        #expect(usecase.checkVersion("1.0.0") == .optional(url: url))
        #expect(usecase.checkVersion("1.5.0") == .optional(url: url))
        #expect(usecase.checkVersion("2.0.0") == .none)
        #expect(usecase.checkVersion("3.0.0") == .none)
    }
    
    @Test("min max 거꾸로 넣음 = min version이 우선순위 높음") func 거꾸로() {
        // given
        let remoteConfig = MockVersionConfigManager()
        let usecase = VersionCheckUsecaseImpl(remoteVersionConfig: remoteConfig)
        let url = ""
        
        remoteConfig.setup(testCase: .normal(appStoreUrl: url, minVersion: "2.0.0", maxVersion: "1.0.0"))
        
        // when
        
        // then
        #expect(usecase.checkVersion("1.9.0") == .required(url: url), "min버전이 우선순위가 높음")
        #expect(usecase.checkVersion("2.0.0") == .none, "min버전이 우선순위가 높음")
    }
    
    @Test("currentVersion을 이상한걸 넣음") func 세상맘대로다() {
        // given
        let remoteConfig = MockVersionConfigManager()
        let usecase = VersionCheckUsecaseImpl(remoteVersionConfig: remoteConfig)
        let url = ""
        
        remoteConfig.setup(testCase: .normal(appStoreUrl: url, minVersion: "1.0.0", maxVersion: "2.0.0"))
        
        // when
        
        // then
        #expect(usecase.checkVersion("0.9") == .required(url: url), "앞에서부터 채우기 때문에, 2개만 넣어도 비교 실시")
        #expect(usecase.checkVersion("1.3") == .optional(url: url), "앞에서부터 채우기 때문에, 2개만 넣어도 비교 실시")
        #expect(usecase.checkVersion("2.0") == .none)
        #expect(usecase.checkVersion("Bet") == .none, "이상하면 0.0.0이되고, 그럴경우 일단 비교하지 않음")
    }
}
