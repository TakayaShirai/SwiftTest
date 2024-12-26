import Foundation
import XCTest

struct BudgetListScreen {

  let app: XCUIApplication

  private struct Elements {
    static let addBudgetCategoryButton = "AddBudgetCategoryButton"
  }

  lazy var addBudgetCategoryButton: XCUIElement = {
    app.buttons[Elements.addBudgetCategoryButton]
  }()
}
