//  Created by team@verify.as
//  Copyright © 2019 https://verify.as

import UIKit

internal extension UIViewController {

    // MARK: - Internal

    internal var topViewController: UIViewController {
        return presentedViewController?.topViewController ?? self
    }
}
