
[![pod v1.0.0](http://b.repl.ca/v1/pod-v1.0.0-blue.png)](https://cocoapods.org)
[![Carthage compatible](http://b.repl.ca/v1/Carthage-Compatible-brightgreen.png)](https://github.com/Carthage/Carthage)
# [Verify Payments](https://verify.as) iOS SDK
Instant bank payments. Get paid directly to your bank account. No cards needed.
## Intro
### No cards needed
Credit cards have notoriously low penetration in the Middle East region, with 80% of consumers opting to pay with cash instead.

**Verify is digital cash**; it is as good as getting paid in cash, but without having to handle the physical notes yourself.
### Simple API
We've integrated with the largest retail banks in the UAE and Bahrain, so you don't have to. Just integrate with the Verify API once, and you'll get access to all of the financial institutions on the Verify network. What's more is, as more banks join the network, you'll automatically get access to them with no extra work!

## Getting Started
Before you start you need to sign up for a Verify Payments account [here](https://dashboard.verifypayments.com) and get API keys for the SDK following the [instructions](https://docs.verifypayments.com/#api-keys).
## Installation
#### Using CocoaPods
Install the SDK usinn [CocoaPods](https://guides.cocoapods.org/using/getting-started.html) by adding the following pod to your [Podfile](https://guides.cocoapods.org/using/using-cocoapods.html):

	pod 'VerifyPayments', :git => 'https://github.com/verifyas/ios-sdk.git'
#### Using Carthage
You can also install the SDK using [Carthage](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) by adding the following statement to your [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile):

	github "verifyas/ios-sdk"
## Usage
#### 1. Payment Session
To commit a payment, a [Session](https://docs.verifypayments.com/api/#sessions) needs to be [created](https://docs.verifypayments.com/api/#create-a-session). It represents a connection with a customers bank account.
#### 2. Payment Config
[PaymentConfig](VerifyPayments/VerifyPayments/PaymentConfig.swift) needs to be created and set up with your public API key and the id of the Session from above.
```swift
let config = PaymentConfig(publicKey: "pk_test_nszn8hH3uXe6d7FvwU1MpwO6cmEh1lyO", sessionId: "ses_lgoKDnEo3WvM")
```
#### 3. Payment Handlers
You also need to provide the handlers for the payment events.
```swift
let handler = PaymentHandler(
    onComplete: { transfer in
        print("💵✅ VerifyPayment finished: \(transfer)")
    },
    onError: { error in
        print("💵❌ VerifyPayment failed: \(error)")
    },
    onClose: {
        print("💵ℹ️ VerifyPayment closed")
    }
)
```
See [PaymentError](VerifyPayments/VerifyPayments/PaymentError.swift) for more information about possible errors.
#### 4. Show Form
Now everything is set up to show the payment form to a user.
```swift
let payment = VerifyPayments(config: config, handler: handler)
payment.show()
```
#### 5. Payment Transfer
After successful payment a [wrapper](VerifyPayments/VerifyPayments/PaymentTransfer.swift) of a [Transfer](https://docs.verifypayments.com/api/#transfers) object will be passed to `onComplete` handler.
***
See a [demo view controller](Demo-iOS/Demo-iOS/Classes/ViewController.swift) for a more detailed example.
