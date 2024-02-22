//
//  ConverterViewController.swift
//  CurrencyConverter
//
//  Created by Rufan Abdurahmanov on 20.02.24.
//

import UIKit


enum ConvertBy {
    case buy, sell
}


class ConverterViewController: UIViewController {
    
    lazy var topBackgroundView: UIView = {
        let backView = UIView()
        backView.backgroundColor = .lightGray.withAlphaComponent(0.3)
        backView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backView)
        return backView
    }()
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        topBackgroundView.addSubview(button)
        return button
    }()
    
    
    lazy var converterTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.rowHeight = 92
        table.dataSource = self
        table.delegate = self
        table.allowsSelection = false
        table.showsVerticalScrollIndicator = false
        table.register(ConverterTableCell.self, forCellReuseIdentifier: ConverterTableCell.id)
        view.addSubview(table)
        return table
    }()
    
    
    lazy var segmentController: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Alış", "Satış"])
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.backgroundColor = .lightGray.withAlphaComponent(0.5)
        topBackgroundView.addSubview(segment)
        return segment
    }()
    
    var currencies: [Currency]
    
    var calculatedCurrencies: [Currency]
    
    init(currencies: [Currency]) {
        self.currencies = currencies
        self.calculatedCurrencies = currencies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var convertBy: ConvertBy = .buy
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override var disablesAutomaticKeyboardDismissal: Bool {
           get {
               return true // Return false to allow automatic keyboard dismissal
           }
           set {
               // You can optionally implement custom behavior when setting the value
           }
       }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.size.height, right: 0)
        converterTableView.contentInset = contentInsets
    }

    
    // Reset
    @objc private func keyboardWillHide(notification: Notification) {
        converterTableView.contentInset = .zero
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func segmentValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.convertBy = .buy
            break
        case 1:
            self.convertBy = .sell
            break
        default:
            break
        }
       
        DispatchQueue.main.async {
            self.calculatedCurrencies = self.currencies
            self.converterTableView.reloadData()
        }
    }
    
    
    private func updateCurrencies(_ newValue: Double, at index: Int) {
        let baseCurrency = currencies[index]
        self.calculatedCurrencies = currencies
        
        switch convertBy {
        case .buy:
            for i in 0..<calculatedCurrencies.count {
                if i != index {
                    var updatedCurrency: Currency = calculatedCurrencies[i]
                    updatedCurrency.buy = newValue * (baseCurrency.buy / updatedCurrency.buy)
                    calculatedCurrencies[i] = updatedCurrency
                }
            }
            calculatedCurrencies[index].buy = newValue
        case .sell:
            for i in 0..<calculatedCurrencies.count {
                if i != index {
                    var updatedCurrency: Currency = calculatedCurrencies[i]
                    updatedCurrency.sell = newValue * (baseCurrency.sell / updatedCurrency.sell)
                    calculatedCurrencies[i] = updatedCurrency
                }
            }
            calculatedCurrencies[index].sell = newValue
        }
        
        DispatchQueue.main.async {
            self.converterTableView.reloadData()
        }
    }
    
    
    @objc private func dismissAction() {
        self.dismiss(animated: true)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            topBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBackgroundView.heightAnchor.constraint(equalToConstant: 60),
            
            dismissButton.centerYAnchor.constraint(equalTo: topBackgroundView.centerYAnchor),
            dismissButton.trailingAnchor.constraint(equalTo: topBackgroundView.trailingAnchor, constant: -12),
            dismissButton.heightAnchor.constraint(equalToConstant: 40),
            dismissButton.widthAnchor.constraint(equalToConstant: 40),
            
            segmentController.topAnchor.constraint(equalTo: topBackgroundView.topAnchor, constant: 10),
            segmentController.centerXAnchor.constraint(equalTo: topBackgroundView.centerXAnchor),
            segmentController.heightAnchor.constraint(equalToConstant: 40),
            segmentController.widthAnchor.constraint(equalToConstant: 200),
            
            converterTableView.topAnchor.constraint(equalTo: topBackgroundView.bottomAnchor, constant: 4),
            converterTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            converterTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 4),
            converterTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -4)
        ])
    }
}


extension ConverterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        calculatedCurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ConverterTableCell.id, for: indexPath) as? ConverterTableCell else { return UITableViewCell() }
        
        cell.setupCurrencies(convertBy: self.convertBy, currency: calculatedCurrencies[indexPath.row])
        cell.onValueChanged = { [weak self] newValue in
            guard let self = self else { return }
            self.updateCurrencies(newValue, at: indexPath.row)
        }
        return cell
    }
}

