import SwiftUI
import ThemeKit
import SwiftData

struct DetailEditView: View {
    let scrum : DailyScrum
    
    @State private var attendeeName = ""
    @State private var title: String
    @State private var lengthInMinutesAsDouble: Double
    @State private var attendees: [Attendee]
    @State private var theme: Theme
    @Environment(\.dismiss) private var dismiss     //Environment 속성 래퍼 사용시 뷰의 프레젠테이션 모드, 장면 단계, 가시성 또는 색상 구성표 등 뷰의 환경에 저장된 값 읽기 가능
        //Action을 dismiss함
    @Environment(\.modelContext) private var context
    
    private let isCreatingScrum: Bool
    // 이제 바인딩을 사용하여 스크럼을 업데이트 하지 않으므로 새 스크럼인지 업데이트인지 판별하는 논리 필요
    init(scrum: DailyScrum?){
        let scrumToEdit: DailyScrum
        if let scrum {  // cf.java if(scrum != null) ..
            scrumToEdit = scrum
            isCreatingScrum = false
        } else {
            scrumToEdit = DailyScrum(title: "", attendees: [], lengthInMinutes: 5, theme: .sky)
            isCreatingScrum = true
        }
        
        self.scrum = scrumToEdit
        self.title = scrumToEdit.title
        self.lengthInMinutesAsDouble = scrumToEdit.lengthInMinutesAsDouble
        self.attendees = scrumToEdit.attendees
        self.theme = scrumToEdit.theme
    }
    
    
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")){
                TextField("Title", text: $title)
                HStack{
                    Slider(value : $lengthInMinutesAsDouble, in: 5...30, step: 1){
                        Text("Length")
                    }
                    .accessibilityValue("\(String(format: "%.0f", lengthInMinutesAsDouble)) minutes")
                    Spacer()
                    Text("\(String(format:"%.0f", lengthInMinutesAsDouble)) minutes")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $theme)
            }
            Section(header: Text("Attendees")){
                ForEach(attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    attendees.remove(atOffsets: indices)
                }
                HStack{
                    TextField("New Attendee", text: $attendeeName)
                    Button(action: {
                        withAnimation{
                            let attendee = Attendee(name: attendeeName)
                            attendees.append(attendee)
                            attendeeName = ""
                        }
                    }){
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(attendeeName.isEmpty)
                }
            }
        }
        .toolbar{
            ToolbarItem(placement: .cancellationAction){
                Button("Cancel"){
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction){
                Button("Done"){
                    saveEdits()
                    dismiss()
                }
            }
        }
    }
    
    private func saveEdits(){
        scrum.title = title
        scrum.lengthInMinutesAsDouble = lengthInMinutesAsDouble
        scrum.attendees = attendees
        scrum.theme = theme
        
        if isCreatingScrum{
            context.insert(scrum)
        }
        
        try? context.save()
        
    }
}

#Preview(traits: .dailyScurmSampleData) {
    @Previewable @Query(sort: \DailyScrum.title) var scrums: [DailyScrum]
    DetailEditView(scrum : scrums[0]) // 클로저에서 파라미터를 사용하지 않을때 언더바를 사용함
}
