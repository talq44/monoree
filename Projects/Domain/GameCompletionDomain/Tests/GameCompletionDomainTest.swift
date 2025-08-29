import Testing
@testable import GameCompletionDomain
@testable import GameCompletionDomainTesting
@testable import GameCompletionDomainInterface

struct GameCompletionDomainTests {
    @Test("한번 호출했을때") func oneCall() async {
        // given
        let analytics = AnalyticsCoreMock()
        let remoteConfig = GameConfigManagerMock()
        let sut = GameCompletionUsecaseImpl(
            remoteConfig: remoteConfig,
            analytics: analytics
        )
        // when
        let result = await sut.completeGame(GameCompletionInputImpl(score: 3, gameName: "안녕"))
        
        // then
        #expect(result == .none)
        #expect(analytics.callPostScore == true)
    }
    
    @Test("n번 완료시 광고 노출이 노출되는가") func threeCall() async {
        // given
        let perAd = 3
        let analytics = AnalyticsCoreMock()
        let remoteConfig = GameConfigManagerMock()
        remoteConfig.setup(perAd: perAd)
        let sut = GameCompletionUsecaseImpl(
            remoteConfig: remoteConfig,
            analytics: analytics
        )
        // when
        var types: [GameCompletionResultType] = []
        for _ in 0..<perAd {
            let type = await sut.completeGame(GameCompletionInputImpl(score: 3, gameName: "안녕"))
            types.append(type)
        }
        
        // then
        for (offset, type) in types.enumerated() {
            if offset % 3 == perAd {
                #expect(type == .showFullScreenAd)
            } else {
                #expect(type != .showFullScreenAd)
            }
        }
    }
}
