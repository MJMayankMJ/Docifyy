import UIKit

protocol CatagoriesCellDelegate: AnyObject {
    func didClick(on cellType: CatagoriesCells)
}

class TransferTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstrsint: NSLayoutConstraint!
    private var catagoriesArray = [CatagoriesCells]()
    weak var delegate: CatagoriesCellDelegate?
    
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        print("TransferTableViewCell - awakeFromNib called")
        registerNib()
    }
    
    func registerNib(){
        print("TransferTableViewCell - registerNib called")
        collectionView?.register(UINib(nibName: "CatagoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CatagoriesCollectionViewCell")
        
        // Debug collection view configuration
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            print("Collection view layout: \(layout)")
            print("Layout scroll direction: \(layout.scrollDirection.rawValue)") // 0 = vertical, 1 = horizontal
            print("Layout item size: \(layout.itemSize)")
            print("Layout section insets: \(layout.sectionInset)")
        } else {
            print("Failed to get collection view layout")
        }
        
        print("Collection view frame: \(String(describing: collectionView?.frame))")
        print("Collection view constraints height: \(String(describing: collectionViewHeightConstrsint.constant))")
    }
    
    func reloadCell(catagoriesArray: [CatagoriesCells]) {
        print("TransferTableViewCell - reloadCell called with \(catagoriesArray.count) items")
        self.catagoriesArray = catagoriesArray
        
        // Calculate the needed height for the collection view based on item count
        let itemsPerRow: CGFloat = 4
        let numberOfRows = ceil(CGFloat(catagoriesArray.count) / itemsPerRow)
        let rowHeight: CGFloat = (collectionView.frame.size.width / 4) + 10 // Same as your cell height calculation
        let totalHeight = numberOfRows * rowHeight + 20 // Add padding
        
        print("Calculated rows: \(numberOfRows), row height: \(rowHeight), total height: \(totalHeight)")
        
        // Set the collection view height if needed
        if totalHeight > collectionViewHeightConstrsint.constant {
            collectionViewHeightConstrsint.constant = totalHeight
            print("Updated collection view height constraint to: \(totalHeight)")
        }
        
        self.collectionView.reloadData()
        
        // Force layout update
        self.layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: -  UICollectionViewDelegate,UICollectionViewDataSource
extension TransferTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("TransferTableViewCell - numberOfItemsInSection called, returning \(catagoriesArray.count)")
        return catagoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("TransferTableViewCell - cellForItemAt called for index \(indexPath.row)")
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatagoriesCollectionViewCell", for: indexPath) as? CatagoriesCollectionViewCell {
            cell.setData(data: catagoriesArray[indexPath.row].rawValue)
            print("Configured cell with data: \(catagoriesArray[indexPath.row].rawValue)")
            return cell
        }
        print("ERROR: Failed to dequeue CatagoriesCollectionViewCell")
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.size.width/4, height: collectionView.frame.size.width/4 + 10)
        print("TransferTableViewCell - sizeForItemAt called, returning size: \(size)")
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("TransferTableViewCell - didSelectItemAt called for index \(indexPath.row)")
        self.delegate?.didClick(on: catagoriesArray[indexPath.row])
    }
}
