//
//  CustomCell.swift
//  sample
//
//  Created by 田中雄也 on 2022/10/03.
//

import UIKit

class CustomCell: UICollectionViewCell {

    let screen_width = UIScreen.main.bounds.size.width
    let screen_height = UIScreen.main.bounds.size.height
    @IBOutlet weak var colorArea: UIImageView!
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    let numberL = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorArea.layer.frame.size = CGSize(width: screen_width/2.2, height: screen_width/4.4)
        numberLabel.font = UIFont.systemFont(ofSize: 20)
        numberLabel.textAlignment = NSTextAlignment.center
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        nameLabel.textAlignment = NSTextAlignment.center
        imageView.frame.size.width = 100
        imageView.frame.size.height = 100
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        numberLabel.text = ""
        nameLabel.text = ""
        imageView.image = UIImage(named: "")
    }

}
