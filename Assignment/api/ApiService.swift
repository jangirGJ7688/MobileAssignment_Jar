//
//  ApiService.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation
import UIKit

class ApiService : NSObject {
    private let baseUrl = ""
    
    private let sourcesURL = URL(string: "https://api.restful-api.dev/objects")!
    
    func fetchDeviceDetailData(completion : @escaping ([DeviceData]) -> ()) {
        if let cachedData = getCachedDeviceData() {
            do {
                let deviceDataArray = try JSONDecoder().decode([DeviceData].self, from: cachedData)
                completion(deviceDataArray)
            } catch {
                print("Error parsing JSON: \(error)")
                completion([])
            }
        } else {
            fetchDeviceDetails(completion: completion)
        }
    }
    
    private func getCachedDeviceData() -> Data? {
        let request = URLRequest(url: sourcesURL, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60.0)
        if let cacheResponse = URLCache.shared.cachedResponse(for: request) {
            return cacheResponse.data
        }
        return nil
    }
    
    private func fetchDeviceDetails(completion : @escaping ([DeviceData]) -> ()){
        let request = URLRequest(url: sourcesURL, cachePolicy: .returnCacheDataElseLoad)
        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completion([]) // Return an empty array on network failure
                return
            }
            if let cacheResponse = urlResponse, data != nil {
                URLCache.shared.storeCachedResponse(CachedURLResponse(response: cacheResponse, data: data!), for: request)
            }
            if let data = data {
                let jsonDecoder = JSONDecoder()
                do {
                    let empData = try jsonDecoder.decode([DeviceData].self, from: data)
                    completion(empData)
                } catch let error {
                    print("Parsing error: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}
