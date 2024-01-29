import UIKit

class InviteViewController: UIViewController {
    @IBOutlet weak var inviteCodeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    @IBAction func addInvitedTownBackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
//    @IBAction func copyCode(_ sender: Any) {
//        UIPasteboard.general.string = String(randomNumber)
//    }
}

