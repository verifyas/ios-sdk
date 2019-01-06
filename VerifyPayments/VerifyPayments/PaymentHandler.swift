//  Created by team@verify.as
//  Copyright © 2019 https://verify.as

import Foundation

public struct PaymentHandler {

    // MARK: - Public

    public typealias CompleteHandler = (PaymentTransfer) -> Void
    public typealias ErrorHandler = (Error) -> Void
    public typealias CloseHandler = () -> Void

    public init(onComplete: @escaping CompleteHandler, onError: @escaping ErrorHandler, onClose: @escaping CloseHandler) {
        self.onComplete = onComplete
        self.onError = onError
        self.onClose = onClose
    }

    // MARK: - Internal

    internal let onComplete: CompleteHandler
    internal let onError: ErrorHandler
    internal let onClose: CloseHandler
}
