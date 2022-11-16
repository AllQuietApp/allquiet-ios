import SwiftUI

struct WelcomeView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .center)
        Text("Hello, world!")
            .padding()
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
