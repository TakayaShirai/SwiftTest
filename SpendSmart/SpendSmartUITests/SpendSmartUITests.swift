import XCTest

final class SpendSmartUITests: XCTestCase {

  private var app: XCUIApplication!

  override func setUp() {
    app = XCUIApplication()
    continueAfterFailure = false
    app.launchArguments = ["UITEST"]
    app.launch()
  }

  func testAddBudgetCategoryAndThenAddAndRemoveTransactionsToThatBudget() {

    var budgetListScreen = BudgetListScreen(app: app)
    var addBudgetScreen = AddBudgetScreen(app: app)
    var budgetDetailScreen = BudgetListDetailScreen(app: app)

    budgetListScreen.addBudgetCategoryButton.tap()

    addBudgetScreen.titleTextField.tap()
    addBudgetScreen.titleTextField.typeText("Groceries")

    addBudgetScreen.amountTextField.tap()
    addBudgetScreen.amountTextField.typeText("100")

    addBudgetScreen.saveBudgetCategoryButton.tap()

    XCTAssertTrue(app.collectionViews.staticTexts["Groceries"].exists)

    // take the user to category detail screen
    app.collectionViews.staticTexts["Groceries"].tap()

    budgetDetailScreen.transactionTitleTextField.tap()
    budgetDetailScreen.transactionTitleTextField.typeText("Milk")

    budgetDetailScreen.transactionAmountTextField.tap()
    budgetDetailScreen.transactionAmountTextField.typeText("48")

    budgetDetailScreen.transactionQuantityTextField.tap()

    budgetDetailScreen.addTransactionButton.tap()

    XCTAssertEqual("Spent: $48.00", budgetDetailScreen.spentText.label)
    XCTAssertEqual("Remaining: $52.00", budgetDetailScreen.remainingText.label)

    // deleting a transaction
    let transactionList = app.collectionViews
    transactionList.children(matching: .cell).element(boundBy: 10).children(matching: .other)
      .element(boundBy: 1).children(matching: .other).element.swipeLeft()

    XCTAssertTrue(transactionList.buttons["Delete"].waitForExistence(timeout: 10))
    transactionList.buttons["Delete"].tap()
    XCTAssertFalse(app.staticTexts["Milk (1)"].exists)

    XCTAssertEqual("Spent: $0.00", budgetDetailScreen.spentText.label)
    XCTAssertEqual("Remaining: $100.00", budgetDetailScreen.remainingText.label)
  }
}
