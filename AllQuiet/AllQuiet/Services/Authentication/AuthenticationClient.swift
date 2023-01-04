import Foundation
 
struct AccessTokenRequest: Codable {
    var userName: String
    var password: String
}

struct AccessTokenResponse: Codable {
    var accessToken: JwtToken?
    var refreshToken: JwtToken?
}

struct JwtToken: Codable {
    var token: String
    var expiresAt: Date
}

class AuthenticationClient {
    var config = Config()
    func login(request: AccessTokenRequest) async -> AccessTokenResponse? {
        let url = config.environment.baseURL + "/accesstoken"
        var request = URLRequest(url: URL(string: url)!)
        if (config.environment.basicAuth != nil) {
            request.setBasicAuth(username: config.environment.basicAuth!.userName, password: config.environment.basicAuth!.password)
        }
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let result = try JSONDecoder().decode(AccessTokenResponse.self, from: data)
            return result
        }
        catch {
            debugPrint("Error loading \(url): \(String(describing: error))")
            return nil;
        }
    }
}
