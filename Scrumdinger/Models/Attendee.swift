import Foundation
import SwiftData

@Model
class Attendee: Identifiable{
    var id : UUID
    var name : String
    var dailyScrum : DailyScrum?
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}

//static var emptyScrum : DailyScrum {
//    DailyScrum(title: "", attendees: [], lengthInMinutes: 5, theme: .sky)
//}
