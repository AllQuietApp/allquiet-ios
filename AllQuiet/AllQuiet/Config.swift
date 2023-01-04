import Foundation
import UIKit
import SwiftUI

struct Config {
    lazy var environment: Environment = {
        if let env = Bundle.main.infoDictionary!  ["Env"] as? String {
            if env == "test" {
                return Environment.Test
            }
        }

        return Environment.Production
    }()
}


enum Environment: String {
    case Test = "test"
    case Production = "production"

    var baseURL: String {
        switch self {
        case .Test: return "https://allquiet-test.app/api"
        case .Production: return "https://allquiet.app/api"
        }
    }
    var basicAuth: BasicAuth? {
        switch self {
        case .Test: return BasicAuth(userName: "all", password: "quiet")
        case .Production: return nil
        }
    }
}

struct BasicAuth {
    var userName: String
    var password: String
}
