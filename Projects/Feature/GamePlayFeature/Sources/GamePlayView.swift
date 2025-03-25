import ComposableArchitecture
import GamePlayFeatureInterface
import SwiftUI

struct GamePlayView: View {
    let store: StoreOf<GamePlayReducer>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                // Stage Number View
                if !viewStore.isShowingProblem && !viewStore.isShowingResult {
                    StageNumberView(stageNumber: viewStore.currentStage)
                }
                
                // Problem View
                if viewStore.isShowingProblem {
                    VStack(spacing: 20) {
                        // Timer
                        Text(String(format: "%.1f", viewStore.remainingTime))
                            .font(.system(size: 60, weight: .bold))
                            .foregroundStyle(.blue)
                        
                        // Problem Content
                        if let problem = viewStore.currentProblem {
                            ProblemView(type: problem)
                        }
                        
                        // Answer Buttons
                        HStack(spacing: 20) {
                            Button("O") {
                                viewStore.send(.answerSelected(true))
                            }
                            .buttonStyle(AnswerButtonStyle(isCorrect: true))
                            
                            Button("X") {
                                viewStore.send(.answerSelected(false))
                            }
                            .buttonStyle(AnswerButtonStyle(isCorrect: false))
                        }
                    }
                    .padding()
                }
                
                // Result View
                if viewStore.isShowingResult {
                    ResultView(
                        totalStages: viewStore.totalStages,
                        results: viewStore.results
                    )
                }
            }
            .onAppear {
                viewStore.send(.showStage)
            }
        }
    }
}

// MARK: - Supporting Views
struct StageNumberView: View {
    let stageNumber: Int
    
    var body: some View {
        Text("\(stageNumber)")
            .font(.system(size: 120, weight: .bold))
            .foregroundStyle(.blue)
            .transition(.scale.combined(with: .opacity))
    }
}

struct ProblemView: View {
    let type: GamePlayType
    
    var body: some View {
        Group {
            switch type {
            case .singleImage(let url, _):
                AsyncImage(url: URL(string: url)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                
            case .singleText(let text, _):
                Text(text)
                    .font(.title)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ResultView: View {
    let totalStages: Int
    let results: [Bool]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("게임 결과")
                .font(.largeTitle)
                .bold()
            
            Text("맞춘 개수: \(results.filter { $0 }.count) / \(totalStages)")
                .font(.title2)
            
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 5), spacing: 10
            ) {
                ForEach(0..<results.count, id: \.self) { index in
                    Circle()
                        .fill(results[index] ? Color.green : Color.red)
                        .frame(width: 44, height: 44)
                        .overlay {
                            Text("\(index + 1)")
                                .foregroundStyle(.white)
                        }
                }
            }
            .padding()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

// MARK: - Button Style
struct AnswerButtonStyle: ButtonStyle {
    let isCorrect: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title)
            .bold()
            .foregroundStyle(.white)
            .frame(width: 80, height: 80)
            .background(isCorrect ? Color.green : Color.red)
            .clipShape(Circle())
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}
