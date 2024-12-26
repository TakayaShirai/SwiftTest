import Foundation
import XCTest

struct AddBudgetScreen {

  let app: XCUIApplication

  private struct Elements {
    static let titleTextField = "titleTextField"
    static let amountTextField = "amountTextField"
    static let saveBudgetCategoryButton = "saveBudgetCategoryButton"
  }

  lazy var titleTextField: XCUIElement = {
    app.textFields[Elements.titleTextField]
  }()

  lazy var amountTextField: XCUIElement = {
    app.textFields[Elements.amountTextField]
  }()

  lazy var saveBudgetCategoryButton: XCUIElement = {
    app.buttons[Elements.saveBudgetCategoryButton]
  }()
}
