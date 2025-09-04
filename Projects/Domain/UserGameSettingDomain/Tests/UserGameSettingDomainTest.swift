import Testing
import UserGameSettingDomainInterface

@testable import UserGameSettingDomain
@testable import UserGameSettingDomainTesting

@Suite struct UserGameSettingDomainTests {
    @Test("getConfig: 로컬/리모트 모두 정상일 때 로컬 우선 적용")
    func getConfig_localOverridesRemote() async {
        // given
        let remote = GameConfigManagerMock()
        remote.setup(testType: .normal(10))  // remote default
        let local = UserLocalDataManagerMock()
        local.setup(testType: .normal(5))  // local override
        let sut = UserGameSettingUsecaseImpl(remoteConfig: remote, localData: local)
        
        // when
        let config = await sut.getConfig()
        
        // then
        #expect(config.questionCount == 5)
        #expect(config.teamCount == 5)
        #expect(config.timePerQuestion == .second(5))
    }
    
    @Test("getConfig: 리모트 에러 시 기본 상수 적용")
    func getConfig_remoteError_usesFallback() async {
        // given
        let remote = GameConfigManagerMock()
        remote.setup(testType: .error)  // trigger fallback constants (10,5,1)
        let local = UserLocalDataManagerMock()
        local.setup(testType: .error)  // no local values
        let sut = UserGameSettingUsecaseImpl(remoteConfig: remote, localData: local)
        
        // when
        let config = await sut.getConfig()
        
        // then
        #expect(config.questionCount == 10)
        #expect(config.teamCount == 1)
        #expect(config.timePerQuestion == .second(5))
    }
    
    @Test("getConfig: 로컬 없음 -> 리모트 설정 사용")
    func getConfig_noLocal_usesRemote() async {
        // given
        let remote = GameConfigManagerMock()
        remote.setup(testType: .normal(7))
        let local = UserLocalDataManagerMock()
        local.setup(testType: .error)  // no local
        let sut = UserGameSettingUsecaseImpl(remoteConfig: remote, localData: local)
        
        // when
        let config = await sut.getConfig()
        
        // then
        #expect(config.questionCount == 7)
        #expect(config.teamCount == 7)
        #expect(config.timePerQuestion == .second(7))
    }
    
    @Test("setter: questionCount 설정 후 getConfig에 반영")
    func setter_setsQuestionCount() async {
        // given
        let remote = GameConfigManagerMock()
        remote.setup(testType: .normal(10))
        let local = UserLocalDataManagerMock()
        local.setup(testType: .error)  // start with no local
        let sut = UserGameSettingUsecaseImpl(remoteConfig: remote, localData: local)
        
        // when
        await sut.setQuestionCount(13)
        let config = await sut.getConfig()
        
        // then
        #expect(config.questionCount == 13)
    }
    
    @Test("setter: timePerQuestion .second(n) 정상 반영")
    func setter_setsTimePerQuestionSecond() async {
        // given
        let remote = GameConfigManagerMock()
        remote.setup(testType: .normal(3))
        let local = UserLocalDataManagerMock()
        local.setup(testType: .error)
        let sut = UserGameSettingUsecaseImpl(remoteConfig: remote, localData: local)
        
        // when
        await sut.setTimePerQuestion(.second(9))
        let config = await sut.getConfig()
        
        // then
        #expect(config.timePerQuestion == .second(9))
    }
    
    @Test("setter: timePerQuestion .unlimited 저장 안 함 (원래 값 유지)")
    func setter_unlimitedDoesNotPersist() async {
        // given
        let remote = GameConfigManagerMock()
        remote.setup(testType: .normal(4))  // default remote is 4 seconds
        let local = UserLocalDataManagerMock()
        local.setup(testType: .normal(6))  // local currently 6
        let sut = UserGameSettingUsecaseImpl(remoteConfig: remote, localData: local)
        
        // when
        await sut.setTimePerQuestion(.unlimited)  // should early return, not persist
        let config = await sut.getConfig()
        
        // then -> local value should remain 6
        #expect(config.timePerQuestion == .second(6))
    }
    
    @Test("setter: teamCount 설정 후 getConfig에 반영")
    func setter_setsTeamCount() async {
        // given
        let remote = GameConfigManagerMock()
        remote.setup(testType: .normal(1))
        let local = UserLocalDataManagerMock()
        local.setup(testType: .error)
        let sut = UserGameSettingUsecaseImpl(remoteConfig: remote, localData: local)
        
        // when
        await sut.setTeamCount(3)
        let config = await sut.getConfig()
        
        // then
        #expect(config.teamCount == 3)
    }
}
