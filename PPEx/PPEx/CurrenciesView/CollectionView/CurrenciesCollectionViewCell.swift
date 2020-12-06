//
//  CurrenciesCollectionViewCell.swift
//  PPEx
//
//  Created by Ben Leung on 4/12/2020.
//

import UIKit

class CurrenciesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var exchangedAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCurrencyName(name: String?) {
        currencyNameLabel.text = name
    }
    
    func setExchangedAmount(amount: String?) {
        exchangedAmount.text = amount
    }
    
}
