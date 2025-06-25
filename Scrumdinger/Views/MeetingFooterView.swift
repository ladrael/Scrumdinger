//
//  MeetingFooterView.swift
//  Scrumdinger
//
//  Created by heonseok on 6/25/25.
//

import SwiftUI
import TimerKit

struct MeetingFooterView: View {
    let speakers : [ScrumTimer.Speaker]
    var skipAction: ()->Void
    private var speakerNumber: Int?{
        guard let index = speakers.firstIndex(where: {!$0.isCompleted}) else {return nil}   // 1.컬렉션의 요소가 주어진 조건을 만족하는 첫 번째 인덱스를 반환합니다. 2.null
        return index + 1
    }
    
    private var isLastSpeaker: Bool {
        // dropLast()         마지막 요소를 제외한, 나머지 요소의 시퀀스를 반환합니다.
        // popLast()          컬렉션의 마지막 요소를 제거하고 반환, 옵셔널 반환 nil
        // removeLast()       컬렉션의 마지막 요소를 제거하고 반환, 컴파일 에러가능성
        // reduce             배열의 모든 요소를 하나의 값으로 합치는 함수
        // reduce(true)       첫번째 값을 true로 사용함
        
        return speakers.dropLast().allSatisfy { $0.isCompleted } // 모든 원소가 특정 조건을 만족시키는지 확인할 때 사용함
        // return speakers.dropLast().reduce(true) { $0 && $1.isCompleted }
    }
    
    private var speakerText: String {
        guard let speakerNumber = speakerNumber else { return "No speaker" }
        return "Speaker \(speakerNumber) of \(speakers.count)"
    }
        
    var body: some View {
        VStack {
            HStack{
                if isLastSpeaker {
                    Text("Last Speaker")
                } else {
                    Text(speakerText)
                    Spacer() //HStack에서는... between과 같음
                    Button(action: skipAction){
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next speaker")
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    @Previewable var speakers = DailyScrum.sampleData[0].attendees
        .map{ $0.name }
        .map{ ScrumTimer.Speaker(name : $0, isCompleted: false) }
    MeetingFooterView(speakers : speakers, skipAction: {})
}
