import Foundation

public extension Date {
    /// 해당 날짜가 오늘인지 여부를 반환합니다.
    /// 이 프로퍼티는 사용자의 현재 달력(Calendar), 지역(Locale), 시간대(TimeZone)를 반영하여 날짜를 일 단위로 비교합니다.
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
}
