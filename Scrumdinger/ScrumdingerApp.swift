import SwiftUI
import SwiftData

@main
struct ScrumdingerApp: App {
    
    var body: some Scene {
        WindowGroup {
            ScrumsView()
        }
        .modelContainer(for: DailyScrum.self)
        //.modelContainer(try! .init(for: DailyScrum.self, configurations: .init(allowsSave:false))) // 테스트용
    }
}
