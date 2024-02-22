//
//  ConverterTableCell.swift
//  CurrencyConverter
//
//  Created by Rufan Abdurahmanov on 20.02.24.
//

import UIKit


class ConverterTableCell: UITableViewCell {
    static let id = "\(ConverterTableCell.self)"
    
    private lazy var currencyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black.withAlphaComponent(0.3)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 5
        contentView.addSubview(imageView)
        return imageView
    }()
    
    
    private lazy var currencyShortNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        return label
    }()
    
    private lazy var currencyNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .gray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        return label
    }()
    
    
    lazy var priceTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.font = .systemFont(ofSize: 30, weight: .medium)
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .decimalPad
        //textField.locale = Locale(identifier: "en_US")
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(didBeginEditing), for: .editingDidBegin)
        contentView.addSubview(textField)
        return textField
    }()
    
    
    var onValueChanged: ((Double) -> Void)?
    
    private let debuncer = Debouncer(delay: 0.75)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white.withAlphaComponent(0.5)
        selectionStyle = .none
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupCurrencies(convertBy: ConvertBy, currency: Currency) {
        self.currencyNameLabel.text = currency.name
        self.currencyShortNameLabel.text = currency.shortName
        
        switch convertBy {
        case .buy:
            self.priceTextField.text = currency.buy.removingTrailingZeros()
        case .sell:
            self.priceTextField.text = currency.sell.removingTrailingZeros()
        }
    }
    
    
 
    @objc
    func didBeginEditing() {
        priceTextField.text = ""
    }
    
    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        
        textField.text = textField.text?.replacingOccurrences(of: ",", with: ".")
        
        if let newValueText = textField.text, let newValue = Double(newValueText) {
            debuncer.debounce {
                self.onValueChanged?(newValue)
            }
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.currencyNameLabel.text = nil
        self.currencyShortNameLabel.text = nil
        self.priceTextField.text = nil
    }
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            currencyImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            currencyImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            currencyImageView.heightAnchor.constraint(equalToConstant: 40),
            currencyImageView.widthAnchor.constraint(equalToConstant: 40),
            
            currencyShortNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28),
            currencyShortNameLabel.leadingAnchor.constraint(equalTo: currencyImageView.trailingAnchor, constant: 12),
            currencyShortNameLabel.heightAnchor.constraint(equalToConstant: 15),
            
            currencyNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -28),
            currencyNameLabel.leadingAnchor.constraint(equalTo: currencyImageView.trailingAnchor, constant: 12),
            currencyNameLabel.heightAnchor.constraint(equalToConstant: 12),
            
            priceTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            priceTextField.leadingAnchor.constraint(equalTo: currencyNameLabel.trailingAnchor, constant: 12),
            priceTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            priceTextField.heightAnchor.constraint(equalToConstant: 34),
            
        ])
    }
    
}
