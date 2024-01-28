import UIKit

protocol AddTownViewControllerDelegate: AnyObject {
    func didAddNewTown(name: String, description: String, randomcode: Int)
}

class AddTownViewController: UIViewController {
    
    weak var delegate: AddTownViewControllerDelegate?
    var randomCode: Int = 0
    
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var townNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateRandomCode()
    }
    
    @IBAction func addTownBackButton(_ sender: Any) {
        print("addTownBackButton 호출")
        self.dismiss(animated: true)
    }
    
    @IBAction func createTownClicked(_ sender: Any) {
        let townName = townNameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        let randomcode = randomCode
        print("createTownClicked 호출됨 - 타운 이름: \(townName), 설명: \(description), 코드: \(randomCode)")

        delegate?.didAddNewTown(name: townName, description: description, randomcode: randomCode)
        self.dismiss(animated: true)
    }
    
    func generateRandomCode() {
        randomCode = Int.random(in: 100_000...999_999)
    }
    
}
