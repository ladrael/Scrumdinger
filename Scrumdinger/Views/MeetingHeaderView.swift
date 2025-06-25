//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by heonseok on 6/25/25.
//

import SwiftUI
import ThemeKit
import TimerKit

struct MeetingHeaderView: View {
    let secondsElapsed: Int
    let secondRemaining: Int
    let theme: Theme
    
    private var totalSeconds: Int {
        secondsElapsed + secondRemaining
    }
    
    private var progress: Double {
        guard totalSeconds > 0 else { return 1 } // 조건이 충종되지 않았을 때 중단됨 else 필수로 필요로함 guard 조건 else
        return Double(secondsElapsed) / Double(totalSeconds)
    }
    
    private var minutesRemaining: Int {
        secondRemaining / 60
    }
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(ScrumProgressViewStyle(theme: theme))
            HStack{
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("\(secondsElapsed)", systemImage: "hourglass.tophalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    Label("\(secondRemaining)", systemImage: "hourglass.bottomhalf.fill")
                        .labelStyle(.trailingIcon)  // 아이콘이 뒤따라 오도록 수정
                }
            }	
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Time remaning")
        .accessibilityValue("\(minutesRemaining) minutes")
        .padding([.top, .horizontal])
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    MeetingHeaderView(secondsElapsed: 60, secondRemaining: 180, theme: .bubblegum)
}
