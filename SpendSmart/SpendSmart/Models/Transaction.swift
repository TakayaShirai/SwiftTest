import Foundation
import SwiftData

@Model
class Transaction {

  var title: String
  var amount: Decimal
  var quantity: Int
  var budgetCategory: BudgetCategory?

  var total: Decimal {
    amount * Decimal(quantity)
  }

  init(title: String, amount: Decimal, quantity: Int) {
    self.title = title
    self.amount = amount
    self.quantity = quantity
  }

  func delete(context: ModelContext) {
    context.delete(self)
  }
}
