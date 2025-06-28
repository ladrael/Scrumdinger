import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @State private var ispresentingNewScrumView = false
    
    var body: some View {
        NavigationStack{
            List($scrums){ $scrum in
                NavigationLink(destination: DetailView(scrum: $scrum)){
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")    // 뒤로가기시에 이 항목을 나타냄
            .toolbar{
                Button(action:{
                    ispresentingNewScrumView = true
                }){
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrums")
            }
        }
        .sheet(isPresented: $ispresentingNewScrumView){
            NewScrumSheet(scrums: $scrums)
        }
    }
}

#Preview {
    @Previewable @State var scrums = DailyScrum.sampleData
    ScrumsView(scrums: $scrums)
}
