//
//  SpeakerArc.swift
//  Scrumdinger
//
//  Created by heonseok on 7/1/25.
//

import SwiftUI

struct SpeakerArc: Shape {
    let speakerIndex : Int
    let totalSpaekrs : Int
    
    private var degreePerSpeaker : Double { //각 각도
        360.0 / Double(totalSpaekrs)
    }
    private var startAngle : Angle {
        Angle(degrees: degreePerSpeaker * Double(speakerIndex) + 1.0)
    }
    private var endAngle: Angle {
        Angle(degrees: startAngle.degrees + degreePerSpeaker - 1.0)
    }
    
    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height) - 24.0
        let radius = diameter / 2.0
        let center = CGPoint(x: rect.midX, y: rect.midY) // 사각형 중심
        return Path { path in
            path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise : false)
        }
    }
    
}
