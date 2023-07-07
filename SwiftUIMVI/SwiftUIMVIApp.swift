import SwiftUI

@main
struct SwiftUIMVI: App {
    var body: some Scene {
        WindowGroup {
          ViewFactory.make()
        }
    }
}
