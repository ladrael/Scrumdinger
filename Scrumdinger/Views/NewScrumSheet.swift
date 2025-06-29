//
//  NewScrumSheet.swift
//  Scrumdinger
//
//  Created by 추헌석 on 6/28/25.
//

import SwiftUI

struct NewScrumSheet: View {
    
    var body: some View {
            NavigationStack{
                DetailEditView(scrum: nil)
        }
    }
}

#Preview {
    NewScrumSheet()
}
