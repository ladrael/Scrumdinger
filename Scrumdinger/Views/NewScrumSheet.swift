//
//  NewScrumSheet.swift
//  Scrumdinger
//
//  Created by 추헌석 on 6/28/25.
//

import SwiftUI

struct NewScrumSheet: View {
    @Binding var scrums : [DailyScrum]
    @State private var newScrum = DailyScrum.emptyScrum
    var body: some View {
            NavigationStack{
                DetailEditView(scrum: $newScrum, saveEdits: {dailyScrum in
                    scrums.append(newScrum)
            })
        }
    }
}

#Preview {
    NewScrumSheet(scrums: .constant(DailyScrum.sampleData))
}
