//
//  BankTableCell.swift
//  Direct
//
//  Created by abuzeid on 5/1/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class BankTableCell: UITableViewCell, TableCell {
    static var cellId: String = "BankTableCell"

    @IBOutlet private  weak var txtLbl: UILabel!
    @IBOutlet private  weak var logoIV: UIImageView!
    func setCellData(_ model: CellDataModel) {
        txtLbl.text = model.paymentName
//        logoIV.setImage(with: model.)
    }

    typealias CellDataModel = ChildPaymentMethod

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func setText() {
        let attributedString = NSMutableAttributedString(string: "مكتب المسافر المباشر للسفر والسياحة\nرقم الحساب: 6534434465656554\nأيبان: SA18 0004 09888 7744 3333", attributes: [
            .font: UIFont(name: "Cairo-Regular", size: 13.0)!,
            .foregroundColor: UIColor(white: 0.0, alpha: 0.86),
            .kern: 0.0,
        ])
        attributedString.addAttribute(.font, value: UIFont(name: "Cairo-Bold", size: 13.0)!, range: NSRange(location: 0, length: 35))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
