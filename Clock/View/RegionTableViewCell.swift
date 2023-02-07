//
//  RegionTableViewCell.swift
//  Clock
//
//  Created by Алина Власенко on 01.02.2023.
//

import UIKit

class RegionTableViewCell: UITableViewCell {
    
    //MARK: - Cell identifier
    static let identifier = "RegionTableViewCell"
    
    //MARK: - UI objects
    private let regionLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        // add subviews
        addSubviews()
        
        // apply constraints
        applyConstraints()
    }

    //MARK: - Required Init
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        contentView.addSubview(regionLbl)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        
        let regionsLblConstraints = [
            regionLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            regionLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            regionLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ]
        
        NSLayoutConstraint.activate(regionsLblConstraints)
        
    }
    
    //MARK: - Configure cell
    //
    public func configure(with model: WorldTime) {
        regionLbl.text = "\(model.city), \(model.region)"
    }
}
