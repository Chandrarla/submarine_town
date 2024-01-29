import UIKit
import Alamofire

protocol AddTownViewControllerDelegate: AnyObject {
    func didAddNewTown(town: Town)
}

class AddTownViewController: UIViewController {
    
    weak var delegate: AddTownViewControllerDelegate?
    var randomCode: Int = 0
    
    var userId = "dummyUserId"
    var accessToken = "dummyAccessToken"
    
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var townNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        generateRandomCode()
    }
    
    @IBAction func addTownBackButton(_ sender: Any) {
        print("addTownBackButton 호출")
        self.dismiss(animated: true)
    }
    
    @IBAction func createTownClicked(_ sender: Any) {
        let townName = townNameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        createTown(userId: userId, accessToken: accessToken, townName: townName, description: description)
    }
    
    private func createTown(userId: String, accessToken: String, townName: String, description: String) {
        // 서버에 타운 생성 요청
        let parameters: [String: Any] = ["userId": userId, "townName": townName]
        let headers: HTTPHeaders = ["accesstoken": accessToken]

        AF.request("https://example.com/users/\(userId)/town/create", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                    // 성공 처리
                print("Town created successfully")
                let newTown = Town(name: townName, description: description, randomcode: self.randomCode)
                self.delegate?.didAddNewTown(town: newTown)
                self.dismiss(animated: true)
            case .failure(let error):
                    // 실패 처리
                    print("Error occurred: \(error)")
            }
        }
    }
    
    func generateRandomCode() {
        randomCode = Int.random(in: 100_000...999_999)
    }
    
}
