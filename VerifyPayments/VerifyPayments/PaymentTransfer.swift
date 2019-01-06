//  Created by team@verify.as
//  Copyright © 2019 https://verify.as

import Foundation

public struct PaymentTransfer: Decodable {

    // MARK: - Public

    public enum Status: String, Decodable {
        case initial
        case succeeded
        case pendingVerification = "pending_verification"
        case failed
    }

    public let id: String
    public let amount: Int
    public let currency: String
    public let description: String
    public let status: Status
    public let sessionId: String
    public let bankId: String
    public let sourceId: String
    public let createdAt: Date
    public let updatedAt: Date
    public let referenceId: String
    public let token: String?

    // MARK: - Internal

    internal static func from(json: Data) -> PaymentTransfer? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)

        return try? decoder.decode(PaymentTransfer.self, from: json)
    }

    // MARK: - Private

    private enum CodingKeys: String, CodingKey {
        case id
        case amount
        case currency
        case description
        case status
        case sessionId = "session_id"
        case bankId = "bank_id"
        case sourceId = "source_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case referenceId = "reference_id"
        case token
    }
}
