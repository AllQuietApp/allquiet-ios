import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Spacer().frame(height: 32)
            VStack {
                Text("Welcome to").font(.subTitle).bold()
                Text("All Quiet").font(.titleLarge).bold()
                Text("Incident escalation done right").font(.regular)
            }
            Spacer()
            
            Image("Logo").resizable().frame(width: 128, height: 128)
            
            Spacer()
            
            VStack {
                Button(action: onSignIn) {
                    Text("Login")
                        .font(.regular)
                        .foregroundColor(Color("TextForeground"))
                        .padding()
                }.background(RoundedRectangle(cornerRadius: 5, style: .continuous))
                Spacer().frame(height: 24)
                Text("Not signed up yet? [Sign up now!](https://allquiet.app/signup)").font(.regular)
            }
            Spacer().frame(height: 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .foregroundColor(.white)
        .background(LinearGradient(gradient: Gradient(colors: [.Background, .Purple200]), startPoint: .top, endPoint: .bottom))
    }
    
    func onSignIn() {
        
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
