// Interface module source code

public protocol KoreanChosungUsecase {
    func getChosung(
        type: KoreanChosungType,
        inputs: [KoreanChosungInput]
    ) -> [any KoreanChosungItem]
}
