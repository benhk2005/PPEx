//
//  CurrencyEntryView.swift
//  PPEx
//
//  Created by Ben Leung on 3/12/2020.
//

import UIKit

class CurrencyEntryView: UIView, NibOwnerLoadble {

    @IBOutlet weak var numberTextField: UITextField!
    
    var delegate: CurrencyEntryViewDelegate?
    
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
    }
    
    func updateValue(input: String?){
        numberTextField.text = input
    }

    @IBAction func editingChanged(_ sender: Any) {
        delegate?.currencyEntryNumberDidChanged(value: numberTextField.text)
    }
    
}

protocol CurrencyEntryViewDelegate {
    
    func currencyEntryNumberDidChanged(value: String?)
    
}
