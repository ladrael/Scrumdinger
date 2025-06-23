//
//  ThemePicker.swift
//  Scrumdinger
//
//  Created by heonseok on 6/23/25.
//

import SwiftUI
import ThemeKit

struct ThemePicker: View {
    @Binding var selection: Theme
    
    var body: some View {
        Picker("Theme", selection: $selection){
            ForEach(Theme.allCases){ theme in
                ThemeView(theme: theme)
                    .tag(theme)
            }
        }
        .pickerStyle(.navigationLink)
    }
}

#Preview {
    @Previewable @State var theme = Theme.periwinkle    // 프리뷰 내부에서만 동적 속성 인라인으로 사용가능한 태그
    ThemePicker(selection: $theme)
}
