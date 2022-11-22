import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @FocusState private var emailFieldIsFocused: Bool
    
    @State private var password: String = ""
    @FocusState private var passwordFieldIsFocused: Bool
    
    var body: some View {


        
        VStack {
            Spacer().frame(height: 32)
            VStack {
                Text("Login").font(.subTitle).bold()
            }
            Spacer().frame(height: 32)
            VStack {
                TextField(
                    "Email",
                    text: $email
                )
                .focused($emailFieldIsFocused)
                .onSubmit {
                    validate(email: email, password: password)
                }
                .padding()
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .border(.secondary)
                
                TextField(
                    "Password",
                    text: $password
                )
                .focused($passwordFieldIsFocused)
                .onSubmit {
                    validate(email: email, password: password)
                }
                .padding()
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .border(.secondary)
                
                Button(action: onLogin) {
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
    
    func validate(email: String?, password: String?) {
        
    }
    
    func onLogin() {
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
