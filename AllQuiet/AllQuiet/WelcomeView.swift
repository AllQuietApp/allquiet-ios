import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            VStack {
                Text("Welcome to").font(.subTitle).bold()
                Text("All Quiet").font(.titleLarge).bold()
                Text("Incident escalation done right").font(.regular)
            }.padding(.top)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(.white)
        .background(LinearGradient(gradient: Gradient(colors: [.Background, .Purple200]), startPoint: .top, endPoint: .bottom))
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
