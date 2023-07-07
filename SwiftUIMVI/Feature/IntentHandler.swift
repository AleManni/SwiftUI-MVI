import Combine
import Foundation

protocol IntentHandler {
  func start()
  func performAction()
}

enum BusinessState {
  case fetchingData
  case error
  case loadedText(String)
}

final class IntentHandlerImpl: IntentHandler {
  private weak var router: Router?
  private let service: Service
  private let stateHandler: BusinessStateHandler
  private let eventEmitter = PassthroughSubject<Void, Never>()
  private var cancellable: AnyCancellable?
  
  init(router: Router,
       service: Service,
       stateHandler: BusinessStateHandler) {
     self.router = router
     self.service = service
    self.stateHandler = stateHandler
   }
  
  func start() {
    cancellable = service.incrementer(from: eventEmitter.eraseToAnyPublisher())
      .receive(on: DispatchQueue.main)
      .sink  (
        receiveCompletion: { [weak self] _ in
          self?.router?.didReachMaximumHits()
        },
        receiveValue: {[weak self] in
          let displayableText = ["Count n.", String($0)].joined(separator: " ")
          self?.stateHandler.update(state: .loadedText(displayableText))
        })
    performAction()
  }
  
  func performAction() {
    stateHandler.update(state: .fetchingData)
    eventEmitter.send()
  }
}
