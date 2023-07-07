// This is just declared as a protocol with Nav coordinator adopting it

protocol Router: AnyObject {
  func didReachMaximumHits()
}
