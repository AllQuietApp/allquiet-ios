import Foundation

struct AccessTokenRequest: Identifiable, Codable{
    var userName: String
    var password: String
}

struct AccessTokenResponse: Identifiable, Codable{
    var userName: String
    var password: String
}

class AuthenticationClient {
    func login(request: AccessTokenRequest): AccessTokenResponse async {
        
        // Learn to read dynamic value here:
        // https://cocoacasts.com/switching-environments-with-configurations
        
        let url = URL(string: baseUrl + "/accesstoken")!
        let urlSession = URLSession.shared

        do {
            let (data, response) = try await urlSession.data(from: url)
            return try JSONDecoder().decode([AccessTokenResponse].self, from: data)
        }
        catch {
            debugPrint("Error loading \(url): \(String(describing: error))")
        }

    }
}
