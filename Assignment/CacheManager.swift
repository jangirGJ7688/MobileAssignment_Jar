class CacheManager {
    private let key = "deviceData"
    
    func setCache(_ data : [DeviceData]) {
        UserDefaults.standard.set(data, forKey: self.key)
    }
    
    func getCache() -> [DeviceData]? {
        return UserDefaults.standard.array(forKey: self.key) as? [DeviceData]
    }
    
}