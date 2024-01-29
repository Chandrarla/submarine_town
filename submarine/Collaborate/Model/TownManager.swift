import Foundation
import Alamofire

class TownManager {
    // 싱글턴 인스턴스 선언
    static let shared = TownManager()
    
    // 더미 데이터 메소드
    func fetchDummyTowns() -> [Town] {
        return [
            Town(name: "Town1", description: "This is a sample town1.", randomcode: 123456),
            Town(name: "Town2", description: "This is a sample town2.", randomcode: 654321),
            // 추가 더미 타운 데이터
        ]
    }
    
    // Town 데이터를 가져오는 메소드 (1단계)
    func fetchTowns(completion: @escaping ([Town]?) -> Void) {
        let url = "https://example.com/towns"
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                // JSON 데이터를 Town 모델로 파싱 (2단계)
                let towns = self.parseTownsData(data: data)
                completion(towns)
            case .failure(let error):
                print("Error: \(error)")
                completion(nil)
            }
        }
    }

    // JSON 데이터를 파싱하는 메소드 (2단계)
    private func parseTownsData(data: Data) -> [Town]? {
        do {
            let decoder = JSONDecoder()
            let towns = try decoder.decode([Town].self, from: data)
            return towns
        } catch {
            print("Error decoding data: \(error)")
            return nil
        }
    }
    
    func createTown(userId: String, accessToken: String, townName: String, completion: @escaping (Bool) -> Void) {
        let url = "https://example.com/users/\(userId)/town/create"
        let parameters: [String: Any] = ["userId": userId, "townName": townName]
        let headers: HTTPHeaders = ["accesstoken": accessToken]

        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
}
