import Foundation



class AccessTokenStore {
    
    func removeAccessToken() {        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "accessToken")
        defaults.removeObject(forKey: "accessTokenExpiresAt")
        defaults.removeObject(forKey: "refreshToken")
        defaults.removeObject(forKey: "refreshTokenExpiresAt")

    }
    
    func setAccessToken(accessTokenResponse: AccessTokenResponse) {
        
        guard let accessToken = accessTokenResponse.accessToken else {
            return
        }
        guard let refreshToken = accessTokenResponse.refreshToken else {
            return
        }
        
        let defaults = UserDefaults.standard
        defaults.set(accessToken.token, forKey: "accessToken")
        defaults.set(Int(accessToken.expiresAt.timeIntervalSince1970), forKey: "accessTokenExpiresAt")
        defaults.set(refreshToken.token, forKey: "refreshToken")
        defaults.set(Int(refreshToken.expiresAt.timeIntervalSince1970), forKey: "refreshTokenExpiresAt")

    }
    
    func getAccessToken() -> AccessTokenResponse? {
        
        let defaults = UserDefaults.standard
        guard let accessToken = defaults.string(forKey: "accessToken") else {
            return nil;
        }
        let accessTokenExpiresAt = defaults.integer(forKey: "accessTokenExpiresAt")
        
        guard let refreshToken = defaults.string(forKey: "refreshToken") else {
            return nil;
        }
        let refreshTokenExpiresAt = defaults.integer(forKey: "refreshTokenExpiresAt")
        
        return AccessTokenResponse(
            accessToken: JwtToken(token: accessToken, expiresAt: Date(timeIntervalSince1970: TimeInterval(accessTokenExpiresAt))),
            refreshToken: JwtToken(token: refreshToken, expiresAt: Date(timeIntervalSince1970: TimeInterval(refreshTokenExpiresAt)))
        )
    }

}
