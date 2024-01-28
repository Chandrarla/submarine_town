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
    
    var numberOfCells: Int = 0
    var towns: [(name: String, description: String, randomcode: Int)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("numberOfItemsInSection 호출됨 - 섹션: \(section), 아이템 수: \(numberOfCells)")
        return numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cellForItemAt 호출됨 - 인덱스 패스: \(indexPath)")
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TownCollectionViewCell else {
            fatalError("Cannot create new cell")
        }
        if cell.townName == nil {
            fatalError("townName is nil")
        }

        let town = towns[indexPath.row]
        cell.townName.text = town.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let selectedTown = towns[indexPath.row]
            presentTownDetails(town: selectedTown)
        }
    
    private func presentTownDetails(town: (name: String, description: String, randomcode: Int)) {
        if let townVC = storyboard?.instantiateViewController(withIdentifier: "TownViewController") as? TownViewController {
            townVC.townName = town.name
            townVC.townDescription = town.description
            townVC.townRandomCode = town.randomcode
            self.navigationController?.pushViewController(townVC, animated: true)
        }
    }
    
    func presentAddTownViewController() {
        let storyboard = UIStoryboard(name: "Collaborate", bundle: nil)
        if let addTownVC = storyboard.instantiateViewController(withIdentifier: "addTownViewController") as? AddTownViewController {
            addTownVC.delegate = self
            self.present(addTownVC, animated: true)
        } else {
            print("AddTownViewController 인스턴스화 실패")
        }
    }
    
    func didAddNewTown(name: String, description: String, randomcode: Int) {
        print("didAddNewTown 호출됨 - 이름: \(name), 설명: \(description), 코드: \(randomcode)")
        towns.append((name: name, description: description, randomcode: randomcode))
        numberOfCells += 1
        collectionView.reloadData()
        print("현재 towns 배열: \(towns)")
    }
}

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
