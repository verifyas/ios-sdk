//  Created by team@verify.as
//  Copyright © 2019 https://verify.as

import Foundation
import UIKit

public struct VerifyPayments {

    // MARK: - Public

    public init(config: PaymentConfig, handler: PaymentHandler) {
        scriptHandler = ScriptHandler(url: config.url, handler: handler)
        onError = handler.onError
    }

    public func show() {
        guard let presentingViewController = UIApplication.shared.delegate?.window??.rootViewController?.topViewController else {
            onError(PaymentError.unableToShow)
            return
        }
        scriptHandler.show(from: presentingViewController)
    }

    public func close() {
        scriptHandler.close()
    }

    // MARK: - Private

    private let onError: PaymentHandler.ErrorHandler
    private let scriptHandler: ScriptHandler
}
