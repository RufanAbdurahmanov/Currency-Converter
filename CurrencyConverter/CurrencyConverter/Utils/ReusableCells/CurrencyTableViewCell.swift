//
//  CurrencyTableViewCell.swift
//  CurrencyConverter
//
//  Created by Rufan Abdurahmanov on 20.02.24.
//

import UIKit

class CurrenciesTableViewCell: UITableViewCell {
    static let id = "\(CurrenciesTableViewCell.self)"
    
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
    
    
    private lazy var buyPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        return label
    }()
    
    
    private lazy var sellPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        return label
    }()
    
    
    private lazy var mbPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        return label
    }()
    
    
    lazy var pricesStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [buyPriceLabel, sellPriceLabel, mbPriceLabel])
        stack.axis = .horizontal
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        return stack
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white.withAlphaComponent(0.5)
        selectionStyle = .none
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupCurrencies(currency: Currency) {
        self.currencyNameLabel.text = currency.name
        self.currencyShortNameLabel.text = currency.shortName
        self.buyPriceLabel.text = String(currency.buy)
        self.sellPriceLabel.text = String(currency.sell)
        self.mbPriceLabel.text = String(currency.mb)
    }
    
    
    private func setupLayout() {
        pricesStackView.distribution = .fillEqually
        //pricesStackView.backgroundColor = .red
        NSLayoutConstraint.activate([
            currencyImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            currencyImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            currencyImageView.heightAnchor.constraint(equalToConstant: 38),
            currencyImageView.widthAnchor.constraint(equalToConstant: 38),
            
            currencyShortNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            currencyShortNameLabel.leadingAnchor.constraint(equalTo: currencyImageView.trailingAnchor, constant: 12),
            currencyShortNameLabel.heightAnchor.constraint(equalToConstant: 15),
            //currencyImageView.widthAnchor.constraint(equalToConstant: 50),
            
            currencyNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            currencyNameLabel.leadingAnchor.constraint(equalTo: currencyImageView.trailingAnchor, constant: 12),
            currencyNameLabel.heightAnchor.constraint(equalToConstant: 12),
            //currencyShortNameLabel.widthAnchor.constraint(equalToConstant: 50),
            
            pricesStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            pricesStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            pricesStackView.heightAnchor.constraint(equalToConstant: 34),
            //pricesStackView.widthAnchor.constraint(equalToConstant: frame.size.width - 90)
            
        ])
    }
    
}
