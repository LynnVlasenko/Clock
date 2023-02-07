//
//  SettingsTableCell.swift
//  Clock
//
//  Created by Алина Власенко on 07.02.2023.
//

import UIKit

class SettingsTableCell: UITableViewCell {
    
    //створюємо комірку для табличок з налаштуваннями
    
    //MARK: - Identifier
    static let identifier = "SettingsTableCell"
        
    //MARK: - UI objects
    //тайтли по лівій стороні таблички
    private let titleLbl: UILabel = {
        let label = UILabel()
        //класна штука, коли треба зминити тільки товщину тексту, а розмір залишити стоковим(типу дефолтним, системним), то можна в ofSize: прописати label.font.pointSize
        label.font = UIFont.systemFont(ofSize: label.font.pointSize, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //лейбла можк бути по правій стороні
    private let propertyLbl: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    //може бути по правій стороні
    private let textField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.tintColor = .systemOrange
        textField.clearButtonMode = .whileEditing //кнопка видалення, коли текст вписується - тобто автоматично додається кнопочка для видалення тексту в один клік
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isHidden = true
        return textField
    }()
    //може бути по правій стороні
    private let propertySwitch: UISwitch = {
        let uiSwicth = UISwitch()
        uiSwicth.translatesAutoresizingMaskIntoConstraints = false
        uiSwicth.isHidden = true
        return uiSwicth
    }()
    
    
    
    
    //MARK: - Init
    //робимо ініт
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear //прозорий бекграунд
        layer.backgroundColor = UIColor.clear.cgColor //прозорий бекграунд
        //contentView.backgroundColor = .clear
        
        contentView.layer.cornerRadius = 10 //вказуємо радіус для таблички
        // add subviews
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
        contentView.addSubview(titleLbl)
        contentView.addSubview(propertyLbl)
        contentView.addSubview(textField)
        contentView.addSubview(propertySwitch)

        
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        
        // title lbl constraints
        let titleLblConstraints = [
            titleLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ]
        
        let propertyLblConstraints = [
            propertyLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            propertyLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ]
        
        let textFieldConstraints = [
            textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            textField.leadingAnchor.constraint(equalTo: titleLbl.trailingAnchor, constant: 10)
        ]
        
        let propertySwitchConstraints = [
            propertySwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            propertySwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ]
        
        NSLayoutConstraint.activate(titleLblConstraints)
        NSLayoutConstraint.activate(propertyLblConstraints)
        NSLayoutConstraint.activate(textFieldConstraints)
        NSLayoutConstraint.activate(propertySwitchConstraints)
        
    }
    
    
    //MARK: - Configure cell
    //наша функція конфігурації з моделлю:
    public func configure(with model: Setting) {
        
        //так як у нас всюди є тайтл, (типу нам не потрібно перевіряти додатково, якщо таке пропетрі, то без тайтлу) - то просто прописуємо що titleLbl.text = model.title:
        titleLbl.text = model.title
        
        //далі прописуємо у свічі умови, які пропетрі передавати для якої комірки
        switch model.property { //перевіряємо дані, передані у property для певної еомірки:
        case .label: //якщо у проперті для комірки передано значення label, то вона матиме наступний вигляд:
            propertyLbl.text = model.propertyValue //передаємо їй введене значення лейбли
            propertyLbl.isHidden = false //вмикаємо відображення лейбли
            
        case .textField: //якщо у проперті для комірки передано значення textField, то вона матиме наступний вигляд:
            textField.placeholder = model.propertyValue//передаємо їй значення для плейсхолдеру, вказане у масиві даних для комірок
            textField.isHidden = false//впікаємо відображення елемента textField
            
        case .uiSwitch: //якщо у проперті для комірки передано значення uiSwitch, то вона матиме наступний вигляд:
            if model.propertyValue == "on" { //якщо передане значення для propertyValue - "on"
                propertySwitch.isOn = true //вмикається світч
                propertySwitch.isHidden = false //вмикаємо відображення свіча
            } else { //якщо інше значення передано у масив
                propertySwitch.isOn = false //вимикаємо світч
                propertySwitch.isHidden = false //відобращення на комірці свіча залишається, але у вимкненомі стані
            }
            
        }
        
        
    }

}
