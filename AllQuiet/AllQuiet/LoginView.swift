import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @FocusState private var emailFieldIsFocused: Bool
    @State private var emailFieldHasError: Bool = false
    
    @State private var password: String = ""
    @FocusState private var passwordFieldIsFocused: Bool
    @State private var passwordFieldHasError: Bool = false
    
    var isValid: Bool {
        return !emailFieldHasError && !passwordFieldHasError
    }
    
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
                .onChange(of: email) { newEmail in
                    validate(email: newEmail, password: password)
                }
                .focused($emailFieldIsFocused)
                .padding()
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .border(emailFieldHasError ? Color.Error : .secondary)
                
                TextField(
                    "Password",
                    text: $password
                )
                .onChange(of: password) { newPassword in
                    validate(email: email, password: newPassword)
                }
                .focused($passwordFieldIsFocused)
                .padding()
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .border(passwordFieldHasError ? Color.Error : .secondary)
                
                Button(action: onLogin) {
                    Text("Login")
                        .font(.regular)
                        .foregroundColor(Color("TextForeground"))
                        .frame(maxWidth: .infinity)
                        .padding()
                }.background(RoundedRectangle(cornerRadius: 4, style: .continuous))
                    .disabled(!isValid)
                    .opacity(isValid ? 1.0 : 0.5)
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
        emailFieldHasError = email?.isEmpty != false
        passwordFieldHasError = password?.isEmpty != false
    }
    
    func onLogin() {
        validate(email: email, password: password)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
