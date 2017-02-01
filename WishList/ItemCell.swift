//
//  ItemCell.swift
//  WishList
//
//  Created by Khoa on 1/31/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var itemDetailLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
 
    @IBOutlet weak var itemTitleLbl: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell( item : Item  ){
        priceLbl.text = "$\(item.price)"
        itemTitleLbl.text = item.title
        itemDetailLbl.text = item.details
        itemImage.image = item.toImage?.image as? UIImage
    }
}
