//
//  CurrencyDropDownView.swift
//  PPEx
//
//  Created by Ben Leung on 4/12/2020.
//

import UIKit

class CurrencyDropDownView: UIView, NibOwnerLoadble {

    @IBOutlet weak var shadowContainer: UIView!
    var delegate: CurrencyDropDownViewDelegate?
    @IBOutlet weak var selectedCurrencyName: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    private func customInit() {
        loadNibContent()
        shadowContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shadowContainerDidClick)))
        selectedCurrencyName.text = Config.BASE_CURRENCY
    }
    
    @objc func shadowContainerDidClick() {
        delegate?.currentDropDownViewDidClick()
    }

    func updateSelectedCurrencyName(currencyName: String) {
        selectedCurrencyName.text = currencyName
    }
    
}

protocol CurrencyDropDownViewDelegate {
    
    func currentDropDownViewDidClick()
    
}
