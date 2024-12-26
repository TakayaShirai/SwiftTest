import Foundation
import SwiftUI

struct ShowMessageKey: EnvironmentKey {
  static var defaultValue: (MessageType) -> Void = { _ in }
}

extension EnvironmentValues {
  var showMessage: (MessageType) -> Void {
    get { self[ShowMessageKey.self] }
    set { self[ShowMessageKey.self] = newValue }
  }
}
