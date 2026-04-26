import Foundation
import StoreKit

@MainActor
final class PremiumManager: ObservableObject {
    @Published private(set) var isPremium = false
    @Published private(set) var products: [Product] = []

    static let premiumProductID = "com.garagebuddy.premium.monthly"

    func loadProducts() async {
        do {
            products = try await Product.products(for: [Self.premiumProductID])
        } catch {
            products = []
        }
    }

    func purchasePremium() async {
        guard let product = products.first else { return }
        do {
            let result = try await product.purchase()
            switch result {
            case .success(let verification):
                if case .verified = verification {
                    isPremium = true
                }
            default:
                break
            }
        } catch {
            // Keep free mode on purchase failures.
        }
    }

    func applyEntitlementsForDebug() {
        // Replace with transaction listener / server validation in production.
        isPremium = false
    }
}
