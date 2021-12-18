
import SwiftUI

public extension View {
  @ViewBuilder
  func noPaddingFor15(edges: Edge.Set, length: CGFloat? = nil) -> some View {
    if #available(iOSApplicationExtension 15, *) {
      self
    } else {
      padding(edges, length)
    }
  }

  @ViewBuilder
  func searchableFor15(text: Binding<String>) -> some View {
    if #available(iOS 15, *) {
      AnyView(searchable(text: text))
    } else {
      AnyView(self)
    }
  }
}
