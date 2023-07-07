enum ViewState {
  case initial, loading
  case loaded(model: Loaded)
  case error(errorMessage: String)
  
  struct Loaded {
    let title: String
    let text: String
    
    static let `default` = Self(title: "", text: "Count n. 0")
  }
}
