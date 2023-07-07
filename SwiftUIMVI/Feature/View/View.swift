import SwiftUI

struct MainView: View {
  
  @ObservedObject
  var store: StateStore<ViewState>
  private let intentHandler: IntentHandler
  
  init(store: StateStore<ViewState>,
       intentHandler: IntentHandler) {
    self.store = store
    self.intentHandler = intentHandler
  }
  
  var body: some View {
    NavigationView { () -> AnyView in
      switch store.state {
      case .initial, .loading:
        return AnyView(LoadingView())
      case .error:
        return AnyView(ErrorView())
      case let .loaded(model):
        return AnyView(ContentView(model: model,
                            onTappedButton: intentHandler.performAction))
      }
    }
    .onAppear {
      print("Start")
      intentHandler.start()
    }
  }
}

// MARK: Subviews

struct LoadingView: View {
  
  var body: some View {
    Text("--- Loading ---")
  }
}


struct ErrorView: View {
  
  var body: some View {
    Text("Error")
  }
}
          

struct ContentView: View {
  
  let model: ViewState.Loaded
  let onTappedButton: () -> Void
  
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundColor(.accentColor)
      Text(model.text)
        .padding(16)
      Button("Next",
             action: onTappedButton)
    }
    .padding(8)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(model: .init(
      title: "Title",
      text: "Text"),
                onTappedButton: {})
  }
}
