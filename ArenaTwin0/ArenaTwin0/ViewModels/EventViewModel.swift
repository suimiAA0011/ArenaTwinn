//
//  Event.swift
//  ArenaTwin0
//
//  Created by salma on 12/04/2025.
//

// ViewModels/EventViewModel.swift
import Foundation

class EventViewModel: ObservableObject {
    @Published var events: [EventModel] = [
        EventModel(title: "الهلال × الاتحاد", date: .now),
        EventModel(title: "النصر × الأهلي", date: .now.addingTimeInterval(86400))
    ]
}
