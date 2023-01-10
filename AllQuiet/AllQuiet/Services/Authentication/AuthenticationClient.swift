import Foundation
 
struct AccessTokenRequest: Codable {
    var userName: String
    var password: String
}

struct JwtToken: Codable {
    var token: String
    var expiresAt: Date
}

struct AccessTokenResponse: Codable {
    var accessToken: JwtToken?
    var refreshToken: JwtToken?
}

class AuthenticationClient {
    var httpClient = HttpClient()
    func login(request: AccessTokenRequest) async throws -> ResultResponse<AccessTokenResponse>? {
        return try await httpClient.post(request: request, url: "/accesstoken", allowedResponseCodes: [200, 201, 401])
    }
}
