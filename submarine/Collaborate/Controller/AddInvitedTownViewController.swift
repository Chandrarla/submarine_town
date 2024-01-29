import UIKit

class AddInvitedTownViewController: UIViewController {
    @IBOutlet weak var inviteCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    @IBAction func addInvitedTownBackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func enterTownClicked(_ sender: Any) {
    }
}
