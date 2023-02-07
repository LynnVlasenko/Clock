//
//  SmartAlarmTableViewCell.swift
//  Clock
//
//  Created by Алина Власенко 02.02.2023.
//

import UIKit

class SmartAlarmTableViewCell: UITableViewCell {

    //MARK: - Identifier
    static let identifier = "SmartAlarmTableViewCell"
    
    //MARK: - UI objects
    private let alarmStatus: UILabel = {
        let label = UILabel()
        label.text = "Немає будильника"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 28)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dayStatus: UILabel = {
        let label = UILabel()
        label.text = "Сьогодні зранку"
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let changeBtn: UIButton = {
        let button = UIButton()
        button.setTitle("ЗМІНИТИ", for: .normal)
        button.setTitleColor(.systemOrange, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        contentView.addSubview(alarmStatus)
        contentView.addSubview(dayStatus)
        contentView.addSubview(changeBtn)
    }
    
    
    //MARK: - apply constraints
    private func applyConstraints() {
        
        let alarmStatusConstraints = [
            alarmStatus.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            //alarmStatus.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            alarmStatus.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            alarmStatus.trailingAnchor.constraint(equalTo: changeBtn.leadingAnchor, constant: -20)
        ]
        
        let dayStatusConstraints = [
            dayStatus.topAnchor.constraint(equalTo: alarmStatus.bottomAnchor, constant: 20),
            dayStatus.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dayStatus.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ]
        
        let changeBtnConstraints = [
            changeBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            changeBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        
        NSLayoutConstraint.activate(alarmStatusConstraints)
        NSLayoutConstraint.activate(dayStatusConstraints)
        NSLayoutConstraint.activate(changeBtnConstraints)
    }

}
