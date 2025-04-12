//
//  StatsViewModel.swift
//  ArenaTwin0
//
//  Created by salma on 08/04/2025.
//

// ViewModels/StatsViewModel.swift
//import Foundation
//import Combine
//
//class StatsViewModel: ObservableObject {
//    @Published var teamStats: [String: String] = ["الاستحواذ": "65%", "التسديدات": "10"]
//    
//    func fetchTeamStats() {
//        // محاكاة جلب البيانات
//        teamStats = ["الاستحواذ": "\(Int.random(in: 50...70))%", "التسديدات": "\(Int.random(in: 5...15))"]
//    }
//}
// ViewModels/StatsViewModel.swift
//import Foundation
//import Combine
//
//class StatsViewModel: ObservableObject {
//
//    
//    func fetchTeamStats(matchID: String) {
//        networkService.fetchLiveStats(matchID: matchID) { result in
//            switch result {
//            case .success(let stats):
//                DispatchQueue.main.async {
//                    self.teamStats = stats
//                }
//            case .failure(let error):
//                print("فشل في جلب الإحصائيات: \(error)")
//            }
//        }
//    }
//}
// ViewModels/StatsViewModel.swift
import Foundation
import Combine
import SwiftUICore

class StatsViewModel: ObservableObject {
    @Published var teamStats: [String: String] = ["الاستحواذ": "65%", "التسديدات": "10"]
    private let networkService = NetworkService()
    @Published var stats: [StadiumStats] = []
    @Published var attendanceChart: [AttendanceData] = []
    @Published var playerStats: [PlayerStat] = []
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchLiveStats()
        fetchAttendanceData()
        fetchPlayerStats()
    }
    
    func fetchLiveStats() {
        stats = [
            StadiumStats(title: "الحضور", value: "52,341", icon: "person.3.fill", color:.blue),
            StadiumStats(title: "سرعة الإنترنت", value: "500 Mbps", icon: "wifi", color: .green),
            StadiumStats(title: "البوابات المفتوحة", value: "14 / 20", icon: "door.left.hand.open", color: .orange),
            StadiumStats(title: "الطقس", value: "27°C مشمس", icon: "sun.max.fill", color: .yellow),
            StadiumStats(title: "المبيعات", value: "SAR 92,300", icon: "cart.fill", color: .purple)
        ]
    }
    
    func fetchAttendanceData() {
        attendanceChart = [
            AttendanceData(time: "قبل المباراة", count: 12000),
            AttendanceData(time: "الشوط الأول", count: 32000),
            AttendanceData(time: "الاستراحة", count: 42000),
            AttendanceData(time: "الشوط الثاني", count: 52341)
        ]
    }
    
    func fetchPlayerStats() {
        isLoading = true
        guard let url = URL(string: "https://mock-api.sportdataapi.com/players") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [PlayerStat].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] stats in
                self?.playerStats = stats
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
        
    }
    func fetchTeamStats(matchID: String) {
        networkService.fetchLiveStats(matchID: matchID) { result in
            switch result {
            case .success(let stats):
                DispatchQueue.main.async {
                    self.teamStats = stats
                }
            case .failure(let error):
                print("فشل في جلب الإحصائيات: \(error)")
            }
        }
    }}

struct StadiumStats: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let icon: String
    let color: Color
}
