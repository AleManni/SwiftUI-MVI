import Combine

protocol StateHandler<T>: AnyObject {
  associatedtype T
  func updateState(_ new: T)
}

class StateStore<T>: ObservableObject {
  @Published
  var state: T

  init(initial: T) {
    self.state = initial
  }
}

extension StateStore: StateHandler {
  
  func updateState(_ new: T) {
    state = new
  }
}
