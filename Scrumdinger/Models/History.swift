//
//  History.swift
//  Scrumdinger
//
//  Created by 추헌석 on 6/28/25.
//

import Foundation

struct History : Identifiable{
    var id: UUID
    var date: Date
    var attendees: [DailyScrum.Attendee]
    
    init(id: UUID = UUID(), date: Date = Date(), attendees: [DailyScrum.Attendee]) {
        self.id = id
        self.date = date
        self.attendees = attendees
    }
}
