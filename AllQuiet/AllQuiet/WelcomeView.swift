import SwiftUI

struct WelcomeView: View {
    var body: some View {
        
        NavigationView {
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
                    NavigationLink(destination: LoginView()) {
                        Text("Login")
                            .font(.regular)
                            .foregroundColor(Color("TextForeground"))
                            .frame(maxWidth: .infinity)
                            .padding()
                    }.background(RoundedRectangle(cornerRadius: 4, style: .continuous))
                    Spacer().frame(height: 24)
                    Text("[Not signed up yet? Sign up now!](https://allquiet.app/signup?utm_source=app)").accentColor(.white).font(.regular)
                }
                Spacer()
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [.Background, .Purple400]), startPoint: .top, endPoint: .bottom))
        }
    }
    
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
