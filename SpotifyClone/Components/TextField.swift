//
//  TextField.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 10/12/2020.
//

import UIKit

@IBDesignable
class customTextFieldWithIcon: UIView{
    
    // MARK: - Views
    
    var textField: UITextField =  {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    
    // MARK: - Setup views
    
    private func setUpView() {
        
        layer.cornerRadius = 6
        layer.borderWidth = 1
        imageView.tintColor = .black
        
        addSubview(imageView)
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: textField.leadingAnchor, constant: -5),
        ])
        
        
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
        
        // To keep text field wide
        textField.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        imageView.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        
        // To compress textfield before label
        textField.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .horizontal)
        
        
    }
    
    
    
}
