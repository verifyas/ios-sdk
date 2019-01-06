//  Created by team@verify.as
//  Copyright © 2019 https://verify.as

import Foundation
import WebKit

internal class ScriptHandler: NSObject {

    // MARK: - Internal

    internal init(url: URL?, handler: PaymentHandler) {
        self.url = url
        self.handler = handler
    }

    internal func show(from presentingViewController: UIViewController) {
        presentingViewController.present(paymentViewController, animated: true, completion: nil)
    }

    internal func close() {
        paymentViewController.dismiss(animated: true) {
            self.handler.onClose()
        }
    }

    // MARK: - Private

    private let url: URL?
    private let handler: PaymentHandler

    private lazy var paymentViewController: PaymentViewController = {
        let controller = WKUserContentController()
        controller.add(self, name: "onClose")
        controller.add(self, name: "onComplete")

        return PaymentViewController(url: url, userContentController: controller) { [weak self] error in
            self?.handler.onError(error)
            self?.close()
        }
    }()
}

extension ScriptHandler: WKScriptMessageHandler {

    // MARK: - Internal

    internal func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {

        case "onClose":
            close()

        case "onComplete":
            guard let jsonString = message.body as? String, let json = jsonString.data(using: .utf8) else {
                handler.onError(PaymentError.invalidResponse)
                return
            }
            guard let transfer = PaymentTransfer.from(json: json) else {
                handler.onError(PaymentError.invalidResponse)
                return
            }
            handler.onComplete(transfer)

        default:
            assert(false, "received unknown message \(message.name)")
        }
    }
}
