//
//  ContentViewModel.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation


class ContentViewModel : ObservableObject {
    
    private let apiService = ApiService()
    @Published var navigateDetail: DeviceData? = nil
    @Published var data: [DeviceData]?
    private var allDeviceData: [DeviceData]? = []
    @Published var searchText: String = ""
    
    init() {
        self.fetchAPI()
    }

    func fetchAPI() {
        apiService.fetchDeviceDetailData { data in
            DispatchQueue.main.async {
                 self.allDeviceData = data
                self.data = data
            }
        }
    }
    
    func navigateToDetail(navigateDetail: DeviceData?) {
        self.navigateDetail = navigateDetail
    }
    
    func filterData() {
        if self.searchText.isEmpty {
            self.data = self.allDeviceData
            return
        }
        guard let allDeviceData = self.allDeviceData else { return }
        self.data = allDeviceData.filter({$0.name.lowercased().contains(self.searchText.lowercased())})
    }
}
