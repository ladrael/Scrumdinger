//
//  ErrorWrapper.swift
//  Scrumdinger
//
//  Created by 추헌석 on 6/30/25.
//

import Foundation

struct ErrorWrapper: Identifiable{
    let id: UUID
    let error: Error
    let guidance: String
    
    init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}

