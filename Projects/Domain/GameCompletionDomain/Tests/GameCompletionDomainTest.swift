import Testing
@testable import GameCompletionDomain
@testable import GameCompletionDomainTesting
@testable import GameCompletionDomainInterface

struct GameCompletionDomainTests {
    @Test("한번 호출했을때") func oneCall() async {
        // given
        let analytics = AnalyticsCoreMock()
        let localData = GameLocalDataManagerMock()
        let remoteConfig = GameConfigManagerMock()

        let sut = GameCompletionUsecaseImpl(
            remoteConfig: remoteConfig,
            localData: localData,
            analytics: analytics
        )
        
        // when
        let result = await sut.completeGame(GameCompletionInputImpl(score: 15, gameName: "안녕"))
        
        // then
        #expect(result == .none)
        #expect(analytics.callPostScore == true)
    }

    @Test("perAd가 5일 경우, 5회 단위로 광고노출이 출력된다.") func fivePerAdAlwaysNone() async {
        // given
        let perAd = 5
        let testCount = 10
        let analytics = AnalyticsCoreMock()
        let localData = GameLocalDataManagerMock()
        let remoteConfig = GameConfigManagerMock()
        remoteConfig.setup(.normal(perAd: perAd))

        let sut = GameCompletionUsecaseImpl(
            remoteConfig: remoteConfig,
            localData: localData,
            analytics: analytics
        )

        // when
        var types: [GameCompletionResultType] = []
        for index in 0..<testCount {
            let type = await sut.completeGame(
                GameCompletionInputImpl(score: index, gameName: "안녕 + \(index)")
            )
            
            types.append(type)
        }

        // then
        types.enumerated().forEach {
            if ($0.offset + 1) % perAd == 0 {
                #expect($0.element == .showFullScreenAd)
            } else {
                #expect($0.element != .showFullScreenAd)
            }
        }
    }
    
    @Test("perAd가 0일 경우, 여러번 완료해도 광고가 노출되지 않는다") func zeroPerAdAlwaysNone() async {
        // given
        let perAd = 0
        let analytics = AnalyticsCoreMock()
        let localData = GameLocalDataManagerMock()
        let remoteConfig = GameConfigManagerMock()
        remoteConfig.setup(.normal(perAd: perAd))

        let sut = GameCompletionUsecaseImpl(
            remoteConfig: remoteConfig,
            localData: localData,
            analytics: analytics
        )

        // when
        var types: [GameCompletionResultType] = []
        for i in 0..<20 {
            let type = await sut.completeGame(
                GameCompletionInputImpl(score: i, gameName: "안녕 + \(i)")
            )
            types.append(type)
        }

        // then
        #expect(types.allSatisfy { $0 != .showFullScreenAd })
    }
    
    @Test("perAd가 마이너스일 경우, 여러번 완료해도 광고가 노출되지 않는다") func minusPerAdAlwaysNone() async {
        // given
        let perAd = -20
        let analytics = AnalyticsCoreMock()
        let localData = GameLocalDataManagerMock()
        let remoteConfig = GameConfigManagerMock()
        remoteConfig.setup(.normal(perAd: perAd))

        let sut = GameCompletionUsecaseImpl(
            remoteConfig: remoteConfig,
            localData: localData,
            analytics: analytics
        )

        // when
        var types: [GameCompletionResultType] = []
        for i in 0..<20 {
            let type = await sut.completeGame(
                GameCompletionInputImpl(score: i, gameName: "안녕 + \(i)")
            )
            types.append(type)
        }

        // then
        #expect(types.allSatisfy { $0 != .showFullScreenAd })
    }
    
    @Test("remoteConfig가 맛이간 경우, 광고를 보여주지 않는다.") func deadFirebaseAlwaysNone() async {
        // given
        let analytics = AnalyticsCoreMock()
        let localData = GameLocalDataManagerMock()
        let remoteConfig = GameConfigManagerMock()
        remoteConfig.setup(.error)

        let sut = GameCompletionUsecaseImpl(
            remoteConfig: remoteConfig,
            localData: localData,
            analytics: analytics
        )

        // when
        var types: [GameCompletionResultType] = []
        for i in 0..<20 {
            let type = await sut.completeGame(
                GameCompletionInputImpl(score: i, gameName: "안녕 + \(i)")
            )
            types.append(type)
        }

        // then
        #expect(types.allSatisfy { $0 != .showFullScreenAd })
    }
    
    @Test("오늘 이미 5번 플레이했을때, 한번더 플레이한다면") func beforePlay5Times() async {
        // given
        let analytics = AnalyticsCoreMock()
        let localData = GameLocalDataManagerMock()
        let remoteConfig = GameConfigManagerMock()
        localData.setup(5)
        remoteConfig.setup(.normal(perAd: 3))

        let sut = GameCompletionUsecaseImpl(
            remoteConfig: remoteConfig,
            localData: localData,
            analytics: analytics
        )

        // when
        let result = await sut.completeGame(GameCompletionInputImpl(score: 5, gameName: "안녕"))

        // then
        #expect(result == .showFullScreenAd, "5번 했었고, 6번째가 되니까")
    }
}
