//
//  CurrenciesViewConfigurator.swift
//  PPEx
//
//  Created by Ben Leung on 4/12/2020.
//

import Foundation

struct CurrenciesViewConfigurator {
    
    static func config() -> CurrenciesViewController {
        let localDataHelper = LocalDataHelper(userDefaults: UserDefaults.standard)
        let interactor = CurrenciesInteractor(apiHelper: APIHelper(), localDataHelper: localDataHelper)
        let viewController = CurrenciesViewController()
        let presenter = CurrenciesPresenter()
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.interactor = interactor
        return viewController
    }
    
}
