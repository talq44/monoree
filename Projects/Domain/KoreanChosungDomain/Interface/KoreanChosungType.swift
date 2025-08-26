import Foundation

public enum KoreanChosungType {
    /// 자음 분리.
    /// ex) 가는 말이 고와야 오는 말이 곱다 > ㄱㄴ ㅁㅇ ㄱㅇㅇ ㅇㄴ ㅁㅇ ㄱㄷ
    case chosung
    /// 모음 분리
    /// ex) 가는 말이 고와야 오는 말이 곱다 > ㅏㅡ ㅏㅣ ㅗㅘㅑ ㅗㅡ ㅏㅣ ㅗㅏ
    case jungsung
    /// 앞글자 보고 맞추기
    /// ex) 가는 말이 고와야 오는 말이 곱다 > 가는 말이 고와야 OO OO OO
    case frontHalf
    /// 뒷글자 보고 맞추기
    /// ex) 가는 말이 고와야 오는 말이 곱다 > OO OO OOO 오는 말이 곱다
    case backHalf
}
