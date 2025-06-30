import SwiftUI
import SwiftData

struct DetailView: View {
    let scrum: DailyScrum

    @State private var isPressentingEditView = false
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some View {
        List{
            Section(header: Text("Meeting Info")){
                NavigationLink(destination: MeetingView(scrum : scrum, errorWrapper: $errorWrapper)){
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundStyle(Color.accentColor)
                }
                HStack{
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .combine)   // Voice Over에서 두 요소를 하나의 문장으로 읽음
                HStack{
                    Label("theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(4)
                        .foregroundStyle(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
            }
            Section(header: Text("Attendnees")){
                ForEach(scrum.attendees){ attendee in
                    Label(attendee.name, systemImage: "person")
                }
            }
            Section(header: Text("History")){
                if scrum.history.isEmpty {
                    Label("No meeting yet", systemImage: "calendar.badge.exclamationmark")
                }
                ForEach(scrum.history){ history in
                    HStack{
                        Image(systemName: "calendar")
                        Text(history.date, style: .date)
                    }
                }
            }
        }
        .navigationTitle(scrum.title)
        .toolbar{
            Button("Edit"){
                isPressentingEditView = true
                
            }
        }
        .sheet(isPresented: $isPressentingEditView) {
            NavigationStack{
                DetailEditView(scrum: scrum)
                .navigationTitle(scrum.title)
            }
        }
        .sheet(item: $errorWrapper, onDismiss: nil){ wrapper in
            ErrorView(errorWrapper: wrapper)
        }
    }
}

#Preview(traits: .dailyScurmSampleData) {
    @Previewable @Query(sort: \DailyScrum.title) var scrums: [DailyScrum]
    NavigationStack{
        DetailView(scrum: scrums[0])
    }
}
