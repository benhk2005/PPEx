//
//  CurrenciesViewController.swift
//  PPEx
//
//  Created by Ben Leung on 3/12/2020.
//

import UIKit
import JGProgressHUD

class CurrenciesViewController: UIViewController {
    
    struct Const{
        static let currencyCellIdentifier = "currencyCellIdentifier"
        static let numberOfColumns = 3
        static let defaultCellSize = CGSize(width: 120, height: 120)
        static let pickerViewSize = CGRect(x:5, y:20, width: 200, height: 140)
    }
    
    var presenter: CurrenciesPresenterInterface?
    @IBOutlet weak var currencyEntryView: CurrencyEntryView!
    @IBOutlet weak var currencyDropDownView: CurrencyDropDownView!
    @IBOutlet weak var currenciesCollectionView: UICollectionView!
    
    var jgProgressHUD: JGProgressHUD = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PPEx"
        presenter?.viewIsReady()
        overrideUserInterfaceStyle = .light     //Not to handle dark mode at this moment
    }
    
    func setupCollectionView() {
        currenciesCollectionView.register(UINib(nibName: "CurrenciesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Const.currencyCellIdentifier)
        currenciesCollectionView.layoutIfNeeded()
        currenciesCollectionView.dataSource = self
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.estimatedItemSize = presenter?.calculateGridSize(numOfColumns: Const.numberOfColumns) ?? Const.defaultCellSize
        flowLayout.itemSize = presenter?.calculateGridSize(numOfColumns: Const.numberOfColumns) ?? Const.defaultCellSize
        currenciesCollectionView.collectionViewLayout = flowLayout
    }
    
    func setupDropDownView() {
        currencyDropDownView.delegate = self
    }
    
    func setupEntryView() {
        currencyEntryView.delegate = self
        currencyEntryView.updateValue(input: FormattingHelper.formatDecimalToString(decimal: Config.DEFAULT_ENTRY, decimalPoint: 0))
    }

}

// MARK: - CurrenciesViewInterface

extension CurrenciesViewController: CurrenciesViewInterface {
    
    func setupView() {
        setupCollectionView()
        setupDropDownView()
        setupEntryView()
    }
    
    func showLoading() {
        jgProgressHUD.show(in: self.view, animated: true)
    }
    
    func hideLoading() {
        jgProgressHUD.dismiss(animated: true)
    }
    
    func showCurrenciesPicker() {
        let currenciesPickerController = UIAlertController(title: "Select currency", message: "\n\n\n\n\n", preferredStyle: .alert)
        let pickerView = UIPickerView(frame: Const.pickerViewSize)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.dataSource = self
        pickerView.delegate = self
        currenciesPickerController.view.addSubview(pickerView)
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: currenciesPickerController.view.topAnchor, constant: 40),
            pickerView.bottomAnchor.constraint(equalTo: currenciesPickerController.view.bottomAnchor, constant: -40),
            pickerView.centerXAnchor.constraint(equalTo: currenciesPickerController.view.centerXAnchor),
            pickerView.widthAnchor.constraint(equalToConstant: 200),
        ])
        currenciesPickerController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            currenciesPickerController.dismiss(animated: true, completion: nil)
        }))
        currenciesPickerController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            currenciesPickerController.dismiss(animated: true, completion: nil)
            self.presenter?.replaceCurrencyWithCandidate()
        }))
        pickerView.selectRow(self.presenter?.getSelectedCurrencyIndex() ?? 0, inComponent: 0, animated: false)
        self.present(currenciesPickerController, animated: true, completion: nil)
    }
    
    func showErrorMsg(message: String) {
        let errorAlertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        errorAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            errorAlertController.dismiss(animated: true, completion: nil)
        }))
        self.present(errorAlertController, animated: true, completion: nil)
    }
    
    func refreshExchangeRate() {
        currenciesCollectionView.reloadData()
    }
    
    func updateCurrencyDropDownView(currency: String) {
        currencyDropDownView.updateSelectedCurrencyName(currencyName: currency)
    }
    
}

// MARK: -

extension CurrenciesViewController: CurrencyEntryViewDelegate {
    
    func currencyEntryNumberDidChanged(value: String?) {
        if let value = value, let decimal = Decimal(string: value) {
            presenter?.updateEntryValue(decimal: decimal)
        }
    }
    
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate

extension CurrenciesViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter?.getCurrenciesListFromCache().count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter?.getCurrenciesListFromCache()[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        presenter?.selectCurrencyCandidate(currency: presenter?.getCurrenciesListFromCache()[row])
    }
    
}

// MARK: - UICollectionViewDataSource

extension CurrenciesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.currencyCellIdentifier, for: indexPath)
        if let cell = cell as? CurrenciesCollectionViewCell {
            let currencyName = presenter?.getCurrenciesListFromCache()[indexPath.row]
            cell.setCurrencyName(name: currencyName)
            if let currencyName = currencyName {
                cell.setExchangedAmount(amount: presenter?.convertRate(targetCurrency: currencyName))
            } else {
                cell.setExchangedAmount(amount: nil)
            }
        }
        return cell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let ready = presenter?.currenciesListIsReady(), ready else { return 0 }
        return presenter?.getCurrenciesListFromCache().count ?? 0
    }
    
}

extension CurrenciesViewController: CurrencyDropDownViewDelegate {
    
    func currentDropDownViewDidClick() {
        presenter?.currentDropDownViewDidClick()
    }
    
}
