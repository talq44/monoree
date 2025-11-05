import Foundation
import AVFoundation

final class SpeakTTSManager {
    static let shared = SpeakTTSManager()
    
    private let synthesizer: AVSpeechSynthesizer
    private let locale = Locale.current.identifier
    
    private init() {
        synthesizer = AVSpeechSynthesizer()
    }
    
    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: locale)
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        synthesizer.speak(utterance)
    }
    
    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}
