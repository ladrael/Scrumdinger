import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrum = DailyScrum.sampleData
    var body: some Scene {
        WindowGroup {
            //MeetingView()
            ScrumsView(scrums: $scrum)
        }
    }
}

