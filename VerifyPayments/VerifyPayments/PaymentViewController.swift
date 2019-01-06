//  Created by team@verify.as
//  Copyright © 2019 https://verify.as

import UIKit
import WebKit

internal class PaymentViewController: UIViewController {

    // MARK: - Internal

    internal init(url: URL?, userContentController: WKUserContentController, onError: @escaping PaymentHandler.ErrorHandler) {
        self.url = url
        self.onError = onError

        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        webView = WKWebView(frame: .zero, configuration: configuration)

        super.init(nibName: nil, bundle: nil)

        webView.navigationDelegate = self
    }

    // MARK: - Private

    private let url: URL?
    private let webView: WKWebView
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    private var loadingObservation: NSKeyValueObservation?
    private let onError: PaymentHandler.ErrorHandler

    // MARK: - NSCoding

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIViewController

    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("init(nibName:bundle:) has not been implemented")
    }

    override func loadView() {
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        view.centerXAnchor.constraint(equalTo: activityIndicator.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: activityIndicator.centerYAnchor).isActive = true

        loadingObservation = webView.observe(\WKWebView.isLoading, options: .new) { [weak self] _, isLoading in
            if isLoading.newValue == true {
                self?.activityIndicator.startAnimating()
            }
            else {
                self?.activityIndicator.stopAnimating()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let url = url else {
            assert(false, "can't create url for payment")
            return
        }

        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension PaymentViewController: WKNavigationDelegate {

    // MARK: - Internal

    internal func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        onError(error)
    }

    internal func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        onError(error)
    }
}
