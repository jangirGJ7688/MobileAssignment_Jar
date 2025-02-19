//
//  ContentView.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @State private var path: [DeviceData] = [] // Navigation path

    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if let computers = viewModel.data {
                    VStack {
                        TextField("Search...", text: $viewModel.searchText)
                            .frame(height: 40)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .tint(Color.black)
                            .autocorrectionDisabled()
                            .overlay {
                                RoundedRectangle(cornerRadius: 4.0)
                                    .stroke(lineWidth: 1.0)
                            }
                            .padding(.horizontal, 10)
                        if !computers.isEmpty {
                            DevicesList(devices: computers) { selectedComputer in
                                viewModel.navigateToDetail(navigateDetail: selectedComputer)
                            }
                        }else {
                            Spacer()
                            Text("No data found")
                                .font(.headline)
                            Spacer()
                        }
                    }
                } else {
                    ProgressView("Loading...")
                }
            }
            .onChange(of: viewModel.searchText, {
                viewModel.filterData()
            })
            .onChange(of: viewModel.navigateDetail, {
                let navigate = viewModel.navigateDetail
                if navigate != nil {
                    path.append(navigate!)
                }
            })
            .navigationTitle("Devices")
            .navigationDestination(for: DeviceData.self) { computer in
                DetailView(device: computer)
            }
            .onAppear {
                viewModel.navigateToDetail(navigateDetail: nil)
            }
        }
    }
}

//#Preview {
//    ContentView()
//}
