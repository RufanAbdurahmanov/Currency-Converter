//
//  CurrencyTableHeaderView.swift
//  CurrencyConverter
//
//  Created by Rufan Abdurahmanov on 20.02.24.
//

import UIKit


class CurrencyTableViewHeader: UIView {
    
    
    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "VALYUTA"
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        return label
    }()
    
    
    
    private lazy var buyPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "ALIŞ"
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        return label
    }()
    
    
    private lazy var sellPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "SATIŞ"
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        return label
    }()
    
    
    private lazy var mbPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "MB"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        return label
    }()
    
    
    lazy var pricesStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [buyPriceLabel, sellPriceLabel, mbPriceLabel])
        stack.axis = .horizontal
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        return stack
    }()
    
    lazy var bottomSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white.withAlphaComponent(0.95)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            currencyLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            currencyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 36),
            currencyLabel.heightAnchor.constraint(equalToConstant: 34),
            
            
            pricesStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            pricesStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            pricesStackView.leadingAnchor.constraint(equalTo: currencyLabel.trailingAnchor, constant: 80),
            pricesStackView.heightAnchor.constraint(equalToConstant: 34),
            
            bottomSeparatorView.heightAnchor.constraint(equalToConstant: 0.5),
            bottomSeparatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            bottomSeparatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            bottomSeparatorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
}
