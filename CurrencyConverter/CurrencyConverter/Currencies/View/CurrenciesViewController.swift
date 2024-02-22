//
//  CurrenciesViewController.swift
//  CurrencyConverter
//
//  Created by Rufan Abdurahmanov on 20.02.24.
//

import UIKit

protocol CurrenciesViewProtocol: AnyObject {
    func getCurrencies()
    func reloadTable()
    func setupLayouts()
}

class CurrenciesViewController: UIViewController, CurrenciesViewProtocol {
    
    lazy var currenciesTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.showsVerticalScrollIndicator = false
        table.rowHeight = 70//62
        table.dataSource = self
        table.delegate = self
        table.register(CurrenciesTableViewCell.self, forCellReuseIdentifier: CurrenciesTableViewCell.id)
        let headerView = CurrencyTableViewHeader(frame: CGRect(x: 0, y: 0, width: table.frame.width, height: 50))
        table.tableHeaderView = headerView
        view.addSubview(table)
        return table
    }()
    
    private lazy var convertButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(goToConverterPage), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 118/255, green: 187/255, blue: 30/255, alpha: 1)
        button.setImage(UIImage(systemName: "arrow.triangle.2.circlepath")?.withConfiguration(UIImage.SymbolConfiguration(weight: .heavy)), for: .normal)
        button.tintColor = .white
        button.setTitle("Konvertasiya", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        return button
    }()

    
    private let viewModel = CurrenciesViewModel(service: CurrenciesMockService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Valyuta mezenneleri"
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    func getCurrencies() {
        viewModel.getCurrencies() {
            self.reloadTable()
        }
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.currenciesTableView.reloadData()
        }
    }
    
    
    @objc private func goToConverterPage() {
        let converterVC = ConverterViewController(currencies: viewModel.currencies)
        self.present(converterVC, animated: true)
    }
    
    
    func setupLayouts() {
        NSLayoutConstraint.activate([
            
            convertButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            convertButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            convertButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            convertButton.heightAnchor.constraint(equalToConstant: 60),
            
            currenciesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            currenciesTableView.bottomAnchor.constraint(equalTo: convertButton.topAnchor, constant: -4),
            currenciesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 4),
            currenciesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -4)
        ])
    }
}

extension CurrenciesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOFRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrenciesTableViewCell.id, for: indexPath) as? CurrenciesTableViewCell else { return UITableViewCell() }
        cell.setupCurrencies(currency: viewModel.itemAtRow(index: indexPath.row))
        return cell
    }
    
}
