import Combine
import Foundation

protocol Service {
  func incrementer(from source: AnyPublisher<Void, Never>) -> AnyPublisher<Int, Never>
}

final class ServiceImpl: Service {
  
  func incrementer(from source: AnyPublisher<Void, Never>) -> AnyPublisher<Int, Never> {
    source
      .scan(0, { sum, _ in sum + 1 })
      .delay(for: 1.5, scheduler: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
}
