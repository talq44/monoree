import Foundation

enum HomeSectionType: String {
    /// https://gds.gmarket.co.kr/components/banners
    /// https://designsystem.line.me/LDSM/components/banner-ex-en
    case banner
    /// admob
    case adBanner
    /// 게임 카테고리
    case category
    /// 좌측에 숫자가 달려있고, 좌우는 width와 같은, 좌우 스크롤이 되는
    case rank
    /// 좌우 스크롤이되는, 1열
    case items1x
    /// 좌우 스크롤이되는, 3열
    case items3x
    
    var rowCount: Int {
        switch self {
        case .banner:
            return 1
        case .adBanner:
            return 1
        case .category:
            return 1
        case .rank:
            return 1
        case .items1x:
            return 1
        case .items3x:
            return 3
        }
    }
    
    var isShownDetailList: Bool {
        switch self {
        case .banner:
            return false
        case .adBanner:
            return false
        case .category:
            return true
        case .rank:
            return true
        case .items1x:
            return true
        case .items3x:
            return true
        }
    }
}
