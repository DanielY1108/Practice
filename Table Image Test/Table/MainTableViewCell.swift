//
//  MainTableViewCell.swift
//  Table
//
//  Created by JinSeok Yang on 2022/10/14.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    var mainImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
     var mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
         label.backgroundColor = .gray
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mainImage, mainLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    
    // 생성자 호출 뒤에 부모클래스에서 받아온 후 초기화
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.addSubview(stackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
       layout()
     

    }
    
    func layout() {
        NSLayoutConstraint.activate([
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
        
        mainLabel.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        
        
    }

    
    
    
}
