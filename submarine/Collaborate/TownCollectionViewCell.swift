import UIKit

class TownCollectionViewCell: UICollectionViewCell {
    @IBOutlet var townButton: UIButton!
    @IBOutlet weak var townName: UILabel!
    
    var collaborateViewController: CollaborateViewController?
    
    @IBAction func townClicked (_ sender: UIButton) {
        
        if let collaborateVC = collaborateViewController {
            if let collectionView = collaborateVC.collectionView,
               let indexPath = collectionView.indexPath(for: self) {
                let town = collaborateVC.towns[indexPath.row]
                let name = town.name
                let description = town.description
                let code = town.randomcode
                
                print("\(name)버튼 클릭")
                
                if let townVC = UIStoryboard(name: "Town", bundle: nil).instantiateViewController(withIdentifier: "townViewController") as? TownViewController {
                    townVC.townName = name
                    townVC.townDescription = description
                    townVC.townRandomCode = code
                    // UINavigationController를 사용하여 화면 전환
                    if let navigationController = collaborateVC.navigationController {
                        navigationController.pushViewController(townVC, animated: true)
                    }
                }
            }
        }
    }
}
