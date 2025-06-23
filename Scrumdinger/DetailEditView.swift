//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by 추헌석 on 6/23/25.
//

import SwiftUI

struct DetailEditView: View {
    
    @State private var scrum = DailyScrum.emptyScrum
    
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")){
                TextField("Title", text: $scrum.title)
            }
            HStack{
                Slider(value : $scrum.lengthInMinutesAsDouble, in: 5...30, step: 1){
                    Text("Length")
                }
                Spacer()
                Text("\(scrum.lengthInMinutes) minutes")
            }
            Section(header: Text("Attendees")){
                ForEach(scrum.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    scrum.attendees.remove(atOffsets: indices)
                    
                }
            }
        }
    }
}

#Preview {
    DetailEditView()
}
