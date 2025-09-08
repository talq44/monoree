import SwiftUI

struct IntroView: View {
    var body: some View {
        ZStack {
            VStack {
                Text("모두의 놀이\n모놀이")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
            }
            VStack {
                Spacer()
                Text("광고 영역")
                    .padding(50)
            }
        }
    }
}

#Preview {
    IntroView()
}
