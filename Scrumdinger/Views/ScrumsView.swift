import SwiftUI

struct ScrumsView: View {
    
    let scrums: [DailyScrum]
    
    var body: some View {
        NavigationStack{
            List(scrums){ scrum in
                NavigationLink(destination: DetailView(scrum: scrum)){
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")    // 뒤로가기시에 이 항목을 나타냄
            .toolbar{
                Button(action:{}){
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrums")
            }
        }
        
    }
}

#Preview {
    ScrumsView(scrums: DailyScrum.sampleData)
    
}
