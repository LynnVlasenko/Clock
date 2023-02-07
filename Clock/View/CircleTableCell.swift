//
//  CircleTableCell.swift
//  Clock
//
//  Created by Алина Власенко on 06.02.2023.
//

import UIKit

class CircleTableCell: UITableViewCell {
    
    //MARK: - Identifier
    static let identifier = "CircleTableCell"
    
    //MARK: - UI objects
    private let circleLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //add subviews
        addSubviews()
        //apply constraints
        applyConstraints()
        
    }
    
    //MARK: - Required Init
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    //MARK: - add subviews
    private func addSubviews() {
        contentView.addSubview(circleLbl)
        contentView.addSubview(timeLbl)
    }
    
    
    //MARK: - apply constraints
    private func applyConstraints() {
        
        let circleLblConstraints = [
            circleLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            circleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ]
        
        let timeLblConstraints = [
            timeLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            timeLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(circleLblConstraints)
        NSLayoutConstraint.activate(timeLblConstraints)
        
    }
    
    //MARK: - configure
    public func configure(with model: Circle) {
        circleLbl.text = "Коло \(model.circle)"
        timeLbl.text = model.time
    }

}
