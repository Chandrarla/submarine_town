import UIKit

class TownViewController: UIViewController {
    
    var townName: String = ""
    var townDescription: String = ""
    var townRandomCode: Int = 0
    
    @IBOutlet weak var inviteCodeButton: UIButton!
    @IBOutlet weak var townBackHomeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("이름: \(townName), 코드: \(townRandomCode)")
    }

    @IBAction func townBackHomeClicked(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let addTownVC = storyBoard.instantiateViewController(identifier: "Main")
        addTownVC.modalPresentationStyle = .overCurrentContext
        self.present(addTownVC, animated: false, completion: nil)
    }
    
    @IBAction func inviteCodeClicked(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: "Town", bundle: nil)
        let addTownVC = storyBoard.instantiateViewController(identifier: "addInvitedTownViewController")
        addTownVC.modalPresentationStyle = .overCurrentContext
        self.present(addTownVC, animated: false, completion: nil)
    }
    
}
