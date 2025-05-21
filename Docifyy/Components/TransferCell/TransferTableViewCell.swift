import UIKit

protocol CatagoriesCellDelegate: AnyObject {
    func didClick(on cellType: CatagoriesCells)
}

class TransferTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    private var catagoriesArray = [CatagoriesCells]()
    weak var delegate: CatagoriesCellDelegate?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerNib()
        
        // 1) Configure flow layout for vertical grid with insets/spacing
        if let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.scrollDirection = .vertical
            flow.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
            flow.minimumInteritemSpacing = 10
            flow.minimumLineSpacing = 10
        }
    }
    
    private func registerNib() {
        collectionView.register(
            UINib(nibName: "CatagoriesCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "CatagoriesCollectionViewCell"
        )
        collectionView.dataSource = self
        collectionView.delegate   = self
    }
    
    // MARK: - Public API
    
    func reloadCell(catagoriesArray: [CatagoriesCells]) {
        self.catagoriesArray = catagoriesArray
        
        // Recalculate height
        let itemsPerRow: CGFloat = 4
        let numberOfRows = ceil(CGFloat(catagoriesArray.count) / itemsPerRow)
        
        // Use the same size calc as in sizeForItemAt:
        let totalSpacing = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInset.left
                         + (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInset.right
                         + ((collectionView.collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing * (itemsPerRow - 1))
        
        let availableWidth = collectionView.bounds.width - totalSpacing
        let itemWidth     = floor(availableWidth / itemsPerRow)
        let rowHeight     = itemWidth + 10   // same extra for label
        
        let totalHeight = (numberOfRows * rowHeight)
                        + ((collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInset.top
                        + (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInset.bottom)
                        + ((numberOfRows - 1) * (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing)
        
        collectionViewHeightConstraint.constant = totalHeight
        collectionView.reloadData()
        layoutIfNeeded()
    }
}

// MARK: - UICollectionViewDataSource

extension TransferTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        catagoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CatagoriesCollectionViewCell",
            for: indexPath
        ) as! CatagoriesCollectionViewCell
        cell.setData(data: catagoriesArray[indexPath.row].rawValue)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension TransferTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        delegate?.didClick(on: catagoriesArray[indexPath.row])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TransferTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flow = collectionViewLayout as! UICollectionViewFlowLayout
        let itemsPerRow: CGFloat = 4
        
        // 1) Total horizontal spacing (insets + gaps)
        let totalSpacing = flow.sectionInset.left
                         + flow.sectionInset.right
                         + (flow.minimumInteritemSpacing * (itemsPerRow - 1))
        
        // 2) Available width
        let availableWidth = collectionView.bounds.width - totalSpacing
        
        // 3) Compute item width
        let itemWidth = floor(availableWidth / itemsPerRow)
        
        // 4) Height = width + label area
        let itemHeight = itemWidth + 10
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

