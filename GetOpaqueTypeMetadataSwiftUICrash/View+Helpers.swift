
import SwiftUI

public extension View {
  @ViewBuilder
  func searchableFor15(text: Binding<String>) -> some View {
    if #available(iOS 15, *) {
      searchable(text: text)
    } else {
      self
    }
  }
}
