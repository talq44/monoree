import SwiftUI

struct IntroView: View {
    var body: some View {
        ZStack {
            VStack {
                Text("모놀이")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 32)
                
                Text("가족도, 친구도, 동료도 함께 즐길 수 있는\n모두의 놀이")
                    .font(.title2)
                    .fontWeight(.semibold)
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
