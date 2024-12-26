import SwiftData
import XCTest

final class SpendSmartTests: XCTestCase {

  private var budgetCategory: BudgetCategory!
  private var context: ModelContext!

  @MainActor
  override func setUp() {
    context = mockContainer.mainContext
    self.budgetCategory = BudgetCategory(title: "Groceries", amount: 300)
    try! self.budgetCategory.save(context: context)
  }

  @MainActor
  func testCalculateTransactionsForBudget() {
    let transactions = [
      Transaction(title: "Milk", amount: 10, quantity: 1),
      Transaction(title: "Bread", amount: 2.5, quantity: 2),
      Transaction(title: "Eggs", amount: 4.75, quantity: 4),
    ]

    for transaction in transactions {
      budgetCategory.addTransaction(context: context, transaction: transaction)
    }

    XCTAssertEqual(34, budgetCategory.total)
  }

  @MainActor
  func testCalculateRemainingBudget() {
    let transactions = [
      Transaction(title: "Milk", amount: 10, quantity: 1),
      Transaction(title: "Bread", amount: 2.5, quantity: 2),
      Transaction(title: "Eggs", amount: 4.75, quantity: 4),
    ]

    for transaction in transactions {
      budgetCategory.addTransaction(context: context, transaction: transaction)
    }

    XCTAssertEqual(266, budgetCategory.remaining)
  }

  func testThrowTitleExceptionWhenInsertingDuplicateBudgetCategory() throws {

    let newBudgetCategory = BudgetCategory(title: "Groceries", amount: 300)
    XCTAssertThrowsError(try newBudgetCategory.save(context: context), "No exception was thrown") {
      error in
      let thrownError = error as? BudgetCategoryError
      XCTAssertNotNil(thrownError)
      XCTAssertEqual(BudgetCategoryError.titleAlreadyExist, thrownError)
    }
  }
}
