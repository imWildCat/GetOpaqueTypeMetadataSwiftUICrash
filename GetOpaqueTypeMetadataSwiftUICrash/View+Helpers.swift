
import SwiftUI

public extension View {
  @ViewBuilder
  func searchableFor15(text: Binding<String>) -> some View {
    if #available(iOS 15, *) {
      AnyView(searchable(text: text))
    } else {
      AnyView(self)
    }
  }
}
