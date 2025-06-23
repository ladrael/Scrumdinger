//
//  ThemeView.swift
//  Scrumdinger
//
//  Created by heonseok on 6/23/25.
//

import SwiftUI
import ThemeKit

struct ThemeView: View {
    let theme : Theme
    
    var body: some View {
        Text(theme.name)
            .padding(4)
            .frame(maxWidth: .infinity)
            .background(theme.mainColor)
            .foregroundStyle(theme.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            
    }
}

#Preview {
    ThemeView(theme: .buttercup)
}
