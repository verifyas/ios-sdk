//  Created by team@verify.as
//  Copyright © 2019 https://verify.as

import UIKit
import VerifyPayments

class ViewController: UIViewController {

    // MARK: - Private

    @IBAction private func onBuyTap(_ sender: UIButton) {
        let config = PaymentConfig(publicKey: "pk_test_nszn8hH3uXe6d7FvwU1MpwO6cmEh1lyO", sessionId: "ses_lgoKDnEo3WvM")

        let handler = PaymentHandler(
            onComplete: { transfer in
                print("💵✅ VerifyPayments finished: \(transfer)")
            },
            onError: { error in
                print("💵❌ VerifyPayments failed: \(error)")
            },
            onClose: {
                print("💵ℹ️ VerifyPayments closed")
            }
        )

        let payment = VerifyPayments(config: config, handler: handler)
        payment.show()
    }
}
