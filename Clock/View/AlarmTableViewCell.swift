//
//  AlarmTableViewCell.swift
//  Clock
//
//  Created by Алина Власенко 02.02.2023.
//

import UIKit


class AlarmTableViewCell: UITableViewCell {
    
    //MARK: - Identifier
    static let identifier = "AlarmTableViewCell"

    //MARK: - UI objects
    private let timeLbl: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 60, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeLbl: UILabel = {
        let label = UILabel()
        label.text = "Будильник"
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let alarmSwitch: UISwitch = {
        let alarmSwitch = UISwitch()
        alarmSwitch.addTarget(self, action: #selector(alarmSwitchAction), for: .allTouchEvents)
        alarmSwitch.translatesAutoresizingMaskIntoConstraints = false
        return alarmSwitch
    }()
    
    //MARK: - actions
    @objc private func alarmSwitchAction() {
        if alarmSwitch.isOn == true {
            timeLbl.textColor = .none
            typeLbl.textColor = .none
        } else {
            timeLbl.textColor = .systemGray
            typeLbl.textColor = .systemGray
        }
    }
    
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
    
    //MARK: - Add subviews
    private func addSubviews() {
        contentView.addSubview(timeLbl)
        contentView.addSubview(typeLbl)
        contentView.addSubview(alarmSwitch)
        
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        
        let timeLblConstraints = [
            timeLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1),
            timeLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ]
        
        let typeLblConstraints = [
            typeLbl.topAnchor.constraint(equalTo: timeLbl.bottomAnchor, constant: -5),
            typeLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            typeLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ]
        
        let alarmSwitchConstraints = [
            alarmSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            alarmSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(timeLblConstraints)
        NSLayoutConstraint.activate(typeLblConstraints)
        NSLayoutConstraint.activate(alarmSwitchConstraints)
        
    }
    
    //MARK: - Configure cell
    //Конфіругуємо дані будильника так як ми самі обираємо дані для відображення
    public func configure(with model: Alarm) {
        timeLbl.text = "\(model.hours):\(model.minutes)"
    }
    
    //MARK: - is Switch hidden
    public func isSwitchHidden(hideStatus: Bool) {
        if hideStatus {
            alarmSwitch.isHidden = true
        } else {
            alarmSwitch.isHidden = false
        }
    }
    
}
