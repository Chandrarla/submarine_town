import UIKit

class CollaborateViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, AddTownViewControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addTownButton: UIButton!
    @IBOutlet weak var addInvitedTownButton: UIButton!
    
    @IBAction func collaborateBackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func addTownClicked(_ sender: UIButton) {
        presentAddTownViewController()
    }
    
    @IBAction func addInvitedTownClicked(_ sender: UIButton){
        presentAddTownViewController()
    }
    
    var numberOfCells: Int = 0
    var towns: [Town] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        towns = TownManager.shared.fetchDummyTowns()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return towns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TownCollectionViewCell else {
            fatalError("Cannot create new cell")
        }
        let town = towns[indexPath.row]
        cell.townName.text = town.name
        cell.collaborateViewController = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedTown = towns[indexPath.row]
    }
    
    func presentAddTownViewController() {
        let storyboard = UIStoryboard(name: "Collaborate", bundle: nil)
        if let addTownVC = storyboard.instantiateViewController(withIdentifier: "addTownViewController") as? AddTownViewController {
            addTownVC.delegate = self
            self.present(addTownVC, animated: false)
        } else {
            print("AddTownViewController 인스턴스화 실패")
        }
    }
    
//    func presentAddInvitedTownViewController() {
//        let storyboard = UIStoryboard(name: "Collaborate", bundle: nil)
//        if let addInvitedTownVC = storyboard.instantiateViewController(withIdentifier: "addInvitedTownViewController") as? AddInvitedTownViewController {
//            addInvitedTownVC.delegate = self
//            self.present(addInvitedTownVC, animated: false)
//        } else {
//            print("AddInvitedTownViewController 인스턴스화 실패")
//        }
//
//    }
    
    func didAddNewTown(town: Town) {
        towns.append(town)
        collectionView.reloadData()
    }
}

//CollectionViewCell 레이아웃 설정
extension CollaborateViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.width
        let spacingBetweenCells: CGFloat = 2
        let numberOfItemsPerRow: CGFloat = 3
        let totalSpacing = (numberOfItemsPerRow - 1) * spacingBetweenCells
        let itemWidth = (collectionViewWidth - totalSpacing) / numberOfItemsPerRow
        return CGSize(width: itemWidth, height: itemWidth)
    }
}
