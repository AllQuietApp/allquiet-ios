import Foundation
import UIKit

struct HttpError : Error {
    let statusCode: Int?
    init() {
        self.statusCode = nil
    }
    init(statusCode: Int) {
        self.statusCode = statusCode
    }
}

struct ResultResponse<ResponseObject: Decodable>: Decodable {
    var object: ResponseObject?
    var succeeded: Bool
    var errors: [ResultError]
}

struct ResultError : Decodable {
    var description: String
}

class HttpClient {
    var config = Config()
    
    func post<Request: Encodable, Response: Decodable>(request: Request, url: String, allowedResponseCodes: [Int] = [200, 201]) async throws -> Response {
        var urlRequest = URLRequest(url: URL(string: config.environment.baseURL + url)!)
        if (config.environment.basicAuth != nil) {
            urlRequest.setBasicAuth(username: config.environment.basicAuth!.userName, password: config.environment.basicAuth!.password)
        }
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        
        let payload = try JSONEncoder().encode(request)
        let (data, response) = try await URLSession.shared.upload(for: urlRequest, from: payload)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HttpError()
        }
        
        if (!allowedResponseCodes.contains(httpResponse.statusCode)) {
            throw HttpError(statusCode: httpResponse.statusCode)
        }
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let result = try decoder.decode(Response.self, from: data)
            return result
        } catch {
            print(error)
            throw error
        }
    }
}
