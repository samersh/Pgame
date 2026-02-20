
import Foundation
import StoreKit

class IAPManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    static let shared = IAPManager()
    
    private override init() {
        super.init()
    }
    
    var products = [SKProduct]()
    
    func getProducts() {
        let productIdentifiers: Set<String> = [
            "100_zen_coins",
            "500_zen_coins",
            "1000_zen_coins",
            "premium_decoration_pack_1",
            "monthly_pass"
        ]
        
        let request = SKProductsRequest(productIdentifiers: productIdentifiers)
        request.delegate = self
        request.start()
    }
    
    func purchaseProduct(product: SKProduct) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        products = response.products
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                // Unlock content
                SKPaymentQueue.default().finishTransaction(transaction)
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                // Restore purchases
                SKPaymentQueue.default().finishTransaction(transaction)
            default:
                break
            }
        }
    }
}
