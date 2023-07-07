import SwiftUI

enum ViewFactory {
  
  static func make() -> some View {
    let store = StateStore(initial: ViewState.initial)
    let model = ModelImpl(stateHandler: store)
    let intentHandler = IntentHandlerImpl(router: NavCoordinator.default,
                                          service: ServiceImpl(),
                                          stateHandler: model)
    return MainView(store: store,
                    intentHandler: intentHandler)
  }
}
