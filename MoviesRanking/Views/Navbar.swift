//
//  Navbar.swift
//  MoviesRanking
//
//  Created by Estefania Sassone on 14/10/2024.
//

import Foundation
import UIKit

class NavBar: UIView {
    
    private let titleLabel = UILabel()
    let backButton = UIButton(type: .system)
    
    init(title: String) {
        super.init(frame: .zero)
        setupView(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(title: String) {
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = UIColor(named: "Color400")
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
                
        addSubview(backButton)

        titleLabel.text = title
        titleLabel.font = UIFont(name: "SourceSans3-Bold", size: 20) ?? UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = UIColor(named: "Color400")
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        backgroundColor = UIColor(named: "GreenIntense")
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4

        var statusBarHeight: CGFloat {
            if #available(iOS 13.0, *) {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    return windowScene.statusBarManager?.statusBarFrame.height ?? 0
                }
            } else {
                return UIApplication.shared.statusBarFrame.height
            }
            return 0
        }
        
        let statusBarView = UIView(frame: CGRect(x: 0, y: -statusBarHeight, width: UIScreen.main.bounds.width, height: statusBarHeight))
        statusBarView.backgroundColor = UIColor(named: "GreenIntense")
        addSubview(statusBarView)
        
        backButton.isHidden = true
    }
    
    @objc private func backButtonTapped() {}
    
    func setBackButtonVisible(_ isVisible: Bool) {
        backButton.isHidden = !isVisible
    }
}
