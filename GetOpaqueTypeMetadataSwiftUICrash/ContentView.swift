//

import SwiftUI

struct ContentView: View {
  static let initialValue = [
    "Foo",
    "bar",
    "baz",
  ]

  @State var listData: [String] = Self.initialValue

  @State var searchKeywords: String = ""

  var body: some View {
    NavigationView {
      List {
        ForEach(listData, id: \.self) { row in
          Text(row)
        }
      }
      .searchableFor15(text: $searchKeywords)
      .onChange(of: searchKeywords) { searchKeywords in
        if searchKeywords.isEmpty {
          listData = Self.initialValue
        } else {
          listData = Self.initialValue.filter { value in
            value.lowercased().contains(searchKeywords.lowercased())
          }
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
