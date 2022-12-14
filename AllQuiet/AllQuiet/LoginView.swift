import SwiftUI

struct LoginView: View {
    let authenticationClient = AuthenticationClient()
    @State private var email: String = "mads@allquiet.app"
    @FocusState private var emailFieldIsFocused: Bool
    @State private var emailFieldHasError: Bool = false
    
    @State private var password: String = "abcd1234"
    @FocusState private var passwordFieldIsFocused: Bool
    @State private var passwordFieldHasError: Bool = false
    
    @State private var errors = [ResultError]()
    
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
                if (!errors.isEmpty) {
                    
                    VStack {
                        Spacer().frame(height: 8)
                        ForEach(errors, id: \.self.description) { error in
                            Text(error.description).foregroundColor(Color.Error).font(.regular)
                        }
                        Spacer().frame(height: 8)
                    }
                        
                }
                
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
    
    func validate(email: String?, password: String?) -> Bool {
        emailFieldHasError = email?.isEmpty != false
        passwordFieldHasError = password?.isEmpty != false
        return !emailFieldHasError && !passwordFieldHasError
    }
    
    func onLogin() {
        let validationResult = validate(email: email, password: password)
        if (validationResult) {
            errors = []
            Task {
                do {
                    guard let result = try await authenticationClient.login(request: AccessTokenRequest(userName: email, password: password)) else {
                        return
                    }
                    
                    if (result.succeeded == false) {
                        errors = result.errors
                    }
                    
                } catch {
                    errors = [ResultError(description: "We're sorry, but an error occured on our side. Please try again.")]
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
