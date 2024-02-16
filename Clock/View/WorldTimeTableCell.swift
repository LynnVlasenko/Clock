//
//  WorldTimeTableCell.swift
//  Clock
//
//  Created by Алина Власенко 31.01.2023.
//

import UIKit

class WorldTimeTableCell: UITableViewCell {

    //MARK: - Identifier
    //створюємо унікальний identifier для комірки
    static let identifier = "WorldTimeTableCell"
    
    //MARK: - UI objects
    //Налаштування UI елементів що знаходяться у комірці
    // difference lbl
    private let differenceLbl: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // city lbl
    private let cityLbl: UILabel = {
        let label = UILabel()
        //label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // time lbl
    private let timeLbl: UILabel = {
        let label = UILabel()
        //label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 60, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
     
    
    //MARK: - Init
    //оверайдимо ініт UITableViewCell(стандартна UI для комірки таблиці) і передаємо у нього функції з розмішенням UI елементів і констрейтами для них
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        // add subviews
        addSubviews()
        
        //apply constraints
        applyConstraints()
    }
    
    
    //MARK: - Required Init
    //поки що не дуже розумію для чого ця штука, але має бути
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        contentView.addSubview(differenceLbl)
        contentView.addSubview(cityLbl)
        contentView.addSubview(timeLbl)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        
        let differenceLblConstraints = [
            differenceLbl.leadingAnchor.constraint(equalTo: cityLbl.leadingAnchor),
            differenceLbl.bottomAnchor.constraint(equalTo: cityLbl.topAnchor, constant: -5)
        ]
        
        let cityLblConstraints = [
            cityLbl.bottomAnchor.constraint(equalTo: timeLbl.bottomAnchor, constant: -10),
            cityLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ]
        
        let timeLblConstraints = [
            timeLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            timeLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            timeLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(timeLblConstraints)
        NSLayoutConstraint.activate(cityLblConstraints)
        NSLayoutConstraint.activate(differenceLblConstraints)
    }
    
    //MARK: - hides time lbls
    public func isTimeLblHidden(hideStatus: Bool) {
        
        if hideStatus {
            timeLbl.isHidden = true
        } else {
            timeLbl.isHidden = false
        }
    }
    //MARK: - Configure cell
    
    //функція що конфігурує дані для комірки - передає дані через константу model, яку ми створили у cell for row at у файлі WorldTimeVC - вона приймає дані масиву, який зберігає обрані дані нового міста і відображає їх у комірці WorldTimeTableCell контроллера WorldTimeVC.
    public func configure(with model: WorldTime) {
        differenceLbl.text = model.difference
        cityLbl.text = model.city
        timeLbl.text = model.time
    }

}
