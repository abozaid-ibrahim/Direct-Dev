//
//  InstituteTableCell.swift
//  Direct
//
//  Created by abuzeid on 5/2/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class InstituteTableCell: UITableViewCell, TableCell {
    @IBOutlet var tagView: TagView!
    typealias CellDataModel = String
    static var cellId: String = "InstituteTableCell"
    func setCellData(_: String) {}

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        tagView.items = [("انترنت مجاني", #imageLiteral(resourceName: "group15")), ("انترنت مجاني", #imageLiteral(resourceName: "group15")), ("انترنت مجاني", #imageLiteral(resourceName: "group15"))]
        tagView.font = UIFont(name: AppFonts.regularFont, size: 10)!
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
