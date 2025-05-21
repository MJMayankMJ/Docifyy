//
//  DetailLabelCollectionViewCell.swift
//  BookAppointment
//
//  Created by Mayank Jangid on 15/05/25.
//

import UIKit

class DetailLabelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerVIew: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(date: String, day: String) {
        dayLabel.text = day.uppercased()
        dateLabel.text = date
        containerVIew.addViewBorder(borderColor: BookAPColors.shadowColor.cgColor, borderWith: 1.0, borderCornerRadius: 10)
    }
}
