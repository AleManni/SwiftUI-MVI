final class NavCoordinator {
  
  static let `default` = NavCoordinator()
}

extension NavCoordinator: Router {
  func didReachMaximumHits() {
    //route to new screen
  }
}
