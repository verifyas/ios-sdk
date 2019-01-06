//  Created by team@verify.as
//  Copyright © 2019 https://verify.as

import Foundation

public struct PaymentConfig {

    // MARK: - Public

    public init(publicKey: String, sessionId: String, tokenize: Bool? = nil, token: String? = nil) {

        var queryItems = [
            URLQueryItem(name: "publicKey", value: publicKey),
            URLQueryItem(name: "sessionId", value: sessionId),
        ]

        if let tokenize = tokenize {
            queryItems.append(URLQueryItem(name: "tokenize", value: "\(tokenize)"))
        }

        if let token = token {
            queryItems.append(URLQueryItem(name: "token", value: token))
        }

        var components = URLComponents()
        components.scheme = "https"
        components.host = "js.verifypayments.com"
        components.path = "/webview/index.html"
        components.queryItems = queryItems

        url = components.url
    }

    // MARK: - Internal

    internal let url: URL?
}
