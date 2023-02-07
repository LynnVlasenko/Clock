//
//  RegionsVCViewController.swift
//  Clock
//
//  Created by Алина Власенко on 31.01.2023.
//

import UIKit

//створюємо протокол в якому буде метод - оновити табличку(в extension WorldTimeVC: UpdateTimeDelegate у файлі WorldTimeVC - 119 рядок) і який має за параметр тип WorldTime
protocol UpdateTimeDelegate {
    func updateTableTime(time: WorldTime)
}


class RegionsVC: UIViewController {
    
    var delegate: UpdateTimeDelegate? //створюємо delegate - вказуємо йому опціональний тип нашого протоколу, що вище
    
    //MARK: - Data
    let timeZoneArray = WorldTimeData.shared.timeZone() //одразу можу викликати метод, так як вже був створений зразок методу за допомогою сінгелтон shared у файлі WorldTimeData. І я можу доступатися до усіх властівостей і методів у класі WorldTimeData. Наразі передаю функцію яка повертає масив timesArray - з даними країн і їх часу.
    
    
    //MARK: - UI objects
    // regions table //сама табличка - список міст, які будемо додавати на екран WorldTimeVC - щоб відобразити час обраного міста
    private let regionsTable: UITableView = {
        let table = UITableView()
        table.register(RegionTableViewCell.self, forCellReuseIdentifier: RegionTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // choose city lbl //Як тайтл зверху відображається
    private let chooseCityLbl: UILabel = {
        let label = UILabel()
        label.text = "Обрати місто"
        //label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // search bar //Пошук по списку міст - тут тільки UI. Функціонал їй не прикручували.
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Пошук"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    // cancel btn //Кнопка "Скасувати". Повертає на попердній вью. - Функція cancelAction передається через селектор
    private let cancelBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Скасувати", for: .normal)
        btn.setTitleColor(UIColor.systemOrange, for: .normal)
        btn.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // change bg
        view.backgroundColor = .systemBackground
        
        // add subviews //Додаємо елементи UI
        addSubviews()
        
        // apply constraints //
        applyConstraints()
        
        // delegates //додаємо делегати для таблички
        applyDelegates()
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(chooseCityLbl)
        view.addSubview(searchBar)
        view.addSubview(cancelBtn)
        view.addSubview(regionsTable)
    }
    
    
    //MARK: - Action for btns
    //Реалізовуємо функціонал кнопки "Скасувати"
    @objc private func cancelAction() {
        dismiss(animated: true) //використовуємо функцію dismiss яка повертає на попередній вью контроллер
    }
    
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        
        let chooseCityLblConstraints = [
            chooseCityLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chooseCityLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        ]
        
        let searchBarConstraints = [
            searchBar.topAnchor.constraint(equalTo: chooseCityLbl.bottomAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            searchBar.trailingAnchor.constraint(equalTo: cancelBtn.leadingAnchor, constant: -1)
        ]
        
        let cancelBtnConstraints = [
            cancelBtn.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            cancelBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -7)
        ]
        
        let regionsTableConstraints = [
            regionsTable.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            regionsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            regionsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            regionsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        
        NSLayoutConstraint.activate(chooseCityLblConstraints)
        NSLayoutConstraint.activate(searchBarConstraints)
        NSLayoutConstraint.activate(cancelBtnConstraints)
        NSLayoutConstraint.activate(regionsTableConstraints)
    }
    

}

//MARK: - UITableViewDelegate & DataSource
extension RegionsVC: UITableViewDelegate, UITableViewDataSource {
    
    // delegates
    private func applyDelegates() {
        regionsTable.delegate = self
        regionsTable.dataSource = self
    }
    
    // number of rows //кількість елементів
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeZoneArray.count
    }
    
    // cell for row at
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //передаємо ідентифікатор комірки - повертаємо відповідну комірку
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RegionTableViewCell.identifier) as? RegionTableViewCell else { return UITableViewCell()}
        
        //створюємо окрему кастомну комірку
        let model = timeZoneArray[indexPath.row] //створюємо константу, яка зберігає в собі наш створений масив timeZoneArray, що приймає функцію timeZone() через WorldTimeData.shared.timeZone() і повертає timesArray - і відображає по індексу дані, які ми хочемо показати на екрані у доданій комірці
        
        cell.configure(with: model) //конфігуруємо через model. передаємо комірці (cell) через крапку функцію яку створили у файлі RegionTableViewCell -> configure(with model: WorldTime) - тобто функція приймає модель з типом WorldTime і повертає дані для комірки в якій всього одна лейбла regionLbl.text = "\(model.city), \(model.region)"
        
        return cell
    }
    
    // did select row at //метод який налаштовує поведінку при натисканні на комірку(коли натискаємо на комірку - він спрацьовує і передає нашу саму табличку і передає indexPath, тобто яку комірку саме ми натиснули)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)//передаємо таблиці метод deselectRow - це метод який переадє певний екшн - коли ми натискаємо на комірку вона підсвічується і потім потухає. Зроблено чисто для анімації.
        
        let timeZone = timeZoneArray[indexPath.row] //створюємо нашу модель, яку ми передамо у делегат. Створюємо на основі того, що ми беремо з нашого масиву часу елемент від indexPath - тобто той який ми натиснули
        
        delegate?.updateTableTime(time: timeZone) //передаємо модель у делегат - тобто прописали змінну delegate? яку сворили на початку файлу вона має опуіональний тип створеного також зверху протоколу UpdateTimeDelegate  - а протокол має функцію updateTableTime, що приймає WorldTime
        
        dismiss(animated: true) //і одразу закриваємо цю вьюшку - dismiss - закриває вью і повертає на попереднє вью
    }
    
}
