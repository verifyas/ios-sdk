//  Created by team@verify.as
//  Copyright © 2019 https://verify.as

public enum PaymentError: Error {

    /**
     - Occurs when unable to decode PaymentTransfer object from data received from the backend
     - When occurs contact team@verify.as
     */
    case invalidResponse

    /**
     - Occurs when unable to retrieve a view controller to present VeirfyPayments on
     - When occurs ensure your application delegate has window property declared and
       both window and its rootViewController set properly
     */
    case unableToShow
}
