import UIKit

public struct Spacing {
    /// 0pt — 요소 간 여백이 필요 없을 때 사용합니다. Divider 겹침 제거 등 정확한 0 간격.
    static public let zero: CGFloat = 0

    /// 1pt — 헤어라인(border, 구분선) 두께나 아주 미세한 간격이 필요할 때.
    static public let hairline: CGFloat = 1

    /// 2pt — 아이콘과 텍스트 사이의 아주 좁은 간격, 촘촘한 컴팩트 UI에서 미세 조정.
    static public let xxs: CGFloat = 2

    /// 4pt — 작은 내부 패딩, 라벨/아이콘 정렬 간격, 컴팩트한 스택 간 최소 여백.
    static public let xs: CGFloat = 4

    /// 8pt — 기본 소형 여백. 수평 스택 간격, 카드 내부의 좁은 패딩 등에 자주 사용.
    static public let s: CGFloat = 8

    /// 12pt — 중간 정도의 여백. 셀 콘텐츠와 주변 요소 간 간격, 섹션 내 패딩.
    static public let m: CGFloat = 12

    /// 16pt — 표준 여백. 컨테이너 내부 패딩, 섹션 간 기본 간격으로 널리 사용.
    static public let l: CGFloat = 16

    /// 20pt — 큰 여백 시작 구간. 카드 간 간격, 섹션 헤더/푸터 주변의 여유 공간.
    static public let xl: CGFloat = 20

    /// 24pt — 넉넉한 여백. 그룹 간 분리, 폼 섹션 구분, 모달 내부 주요 블록 간격.
    static public let xxl: CGFloat = 24

    /// 32pt — 매우 큰 여백. 화면 섹션 전환, 히어로 영역 주변, 스크롤 헤더 하단 간격.
    static public let xxxl: CGFloat = 32
}
