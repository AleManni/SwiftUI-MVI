import Combine
import Foundation

protocol BusinessStateHandler {
  func update(state: BusinessState)
}

final class ModelImpl {
  weak var viewStateHandler: (any StateHandler<ViewState>)?
  
  
  init(stateHandler: any StateHandler<ViewState>) {
    self.viewStateHandler = stateHandler
    viewStateHandler?.updateState(.initial)
  }
}

extension ModelImpl: BusinessStateHandler {
  
  func update(state: BusinessState) {
    switch state {
    case .fetchingData:
      viewStateHandler?.updateState(.loading)
    case .error:
      viewStateHandler?.updateState(.error(errorMessage: "Undefined Error"))
    case let .loadedText(text):
      viewStateHandler?.updateState(.loaded(model: .init(title: "Fixed title",
                                                         text: text)))
    }
  }
}
