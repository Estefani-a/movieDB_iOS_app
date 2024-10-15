//
//  SearchBar.swift
//  MoviesRanking
//
//  Created by Estefania Sassone on 14/10/2024.
//

import Foundation
import UIKit

class SearchBar: UIView {
    
    private let searchBar = UISearchBar()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchBar)
        
        searchBar.barTintColor = UIColor(named: "GreenMedium") //color del fondo
        searchBar.backgroundImage = UIImage()

        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor(named: "GreenMedium") //color de textField
            textField.textColor = UIColor(named: "Color0")
            
            let placeholderText = "Search..."
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor(named: "Color0") ?? .lightGray, //color del placeholder
                .font: UIFont.systemFont(ofSize: 14)
            ]
            textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        }
        
        if let searchIconView = searchBar.searchTextField.leftView as? UIImageView {
            searchIconView.tintColor = UIColor(named: "Color0") //color del ícono de la searchBar
        }
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setDelegate(_ delegate: UISearchBarDelegate) {
        searchBar.delegate = delegate
    }
}

