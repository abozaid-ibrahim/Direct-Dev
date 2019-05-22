//
//  PackagesTableCell.swift
//  Direct
//
//  Created by abuzeid on 5/10/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
class PackagesTableCell: UITableViewCell, TableCell {
    static var cellId: String = "PackagesTableCell"

    func setCellData(_: String) {}

    typealias CellDataModel = String
    @IBOutlet weak var tagView: TagView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        tagView.items = [("مطعم",#imageLiteral(resourceName: "icons8Mesh"))]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
