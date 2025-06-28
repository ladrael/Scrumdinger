import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    
    @State private var editingScrum = DailyScrum.emptyScrum
    @State private var isPressentingEditView = false
    
    var body: some View {
        List{
            Section(header: Text("Meeting Info")){
                NavigationLink(destination: MeetingView(scrum : $scrum)){
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
                editingScrum = scrum
            }
        }
        .sheet(isPresented: $isPressentingEditView) {
            NavigationStack{
                DetailEditView(scrum: $editingScrum, saveEdits: { dailyScrum in
                    scrum = editingScrum
                })
                .navigationTitle(scrum.title)

            }
            
        }
    }
}

#Preview {
    @Previewable @State var scrum = DailyScrum.sampleData[0]
    NavigationStack{
        DetailView(scrum: $scrum)
    }
    
}
