//
//  AlarmVC.swift
//  Clock
//
//  Created by Алина Власенко on 31.01.2023.
//

import UIKit

class AlarmVC: UIViewController {
    
    //наш зовнішний вигляд екрану показує що ми маємо декілька секцій у нашій табличці - тож створюємо їх у масиві. 
    let sections = ["Сон|Пробудження","Інше"]
    
    var alarms = [Alarm]() //створюємо порожній масив з типом нашої моделі Alarm, куди будуть зберігатися нові додані будильники після вибору часу у пікері
    
    //MARK: - UI objects
    private let alarmTable: UITableView = {
        let table = UITableView()
        //реєструємо 2 комірки для нашої таблиці, так як маємо 2 секції. ідентифікатори яких створені у відповідних файлах до кожної секції AlarmTableViewCell і SmartAlarmTableViewCell
        table.register(AlarmTableViewCell.self, forCellReuseIdentifier: AlarmTableViewCell.identifier)
        table.register(SmartAlarmTableViewCell.self, forCellReuseIdentifier: SmartAlarmTableViewCell.identifier)
        return table
    }()
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // change bg
        view.backgroundColor = .systemBackground
        // configure nav bar //передаємо вигляд нашого верхнього Navigation Bar
        configureNavBar()
        // add subviews //Додаємо елементи UI
        addSubviews()
        // apply delegates //передаємо функцію що запускає делегати таблички
        applyDelegates()
        
        //для секцій не потрібні констрейнти, тож ми їх не створюємо і не передаємо. Секції автоматично розділяють комірки, просто стають зверху кожної комірки, при створенні екстеншенів для таблиць ми будемо відштовхуватись від індексів масиву, в якому створені тайтли секцій. Єдине що ми можемо змінити для секцій - це фрейм, розмір і колір.
    }
    
    //MARK: - viedDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        alarmTable.frame = view.bounds //додаємо і розтягуємо табличку на весь екран
    }
    
    
    //MARK: - add subviews
    private func addSubviews() {
        view.addSubview(alarmTable)
    }
    
    
    //MARK: - configure NavBar
    private func configureNavBar() {
        title = "Будильник"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemOrange
        
        // left button
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Змінити", style: .done, target: self, action: #selector(editingMode))
        // right button
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addAlarm))
    }
    
    //MARK: - Actions for Navigation bar items
    // for rigth button
    @objc private func addAlarm() {
        let vc = SetAlarmVC()
        // apply delegate
        vc.delegate = self
        showDetailViewController(vc, sender: self)
    }
    
    // editing mode
    @objc private func editingMode() {
        guard alarms.count != 0 else { return }
        
        if alarmTable.isEditing { //метод, що говорить про те, шо табличка в режимі змінювання. А які самі зміни можна робити ми налаштовуємо у екстеншенах до таблички. Тут ми використали canEditRowAt (коли можна щось змінувати у комірці, але нараці не прописано що саме змінюємо - просто додається по правій стороні комірки знак ">" - що пожемо перейти на екран коригування комірки) і titleForDeleteConfirmationButtonForRowAt - для напису, під час натискання кнопки видалити, дона схоже створюється автоматично завжди.
            alarmTable.isEditing = false
            
            alarmTable.reloadData()
            navigationItem.leftBarButtonItem?.title = "Змінити"
        } else {
            alarmTable.isEditing = true
            
            alarmTable.reloadData()
            navigationItem.leftBarButtonItem?.title = "Готово"
        }
    }
}

//MARK: - SetAlarmDelegate
//робимо розширення яке буде додавати дані в наш масив alarms, коли ми обираємо години і хвилини і натискаємо Зберегти додаються дані у масив і перезапускається наше вью - де буде відображено встановлений будильник. Все відбувається в момент виконання протоколу.
extension AlarmVC: SetAlarmDelegate {
    
    func getAlarm(alarm: Alarm) {
        alarms.append(alarm) //додає Alarm дані до масиву alarms
        alarmTable.reloadData() // і виконує метод оновити табличку - коли табличка починає оновлючатися іде перевірка у екстеншені нижче у функції з методом cellForRowAt - бачить що indexPath.section більше не 0 - і відображає AlarmTableViewCell на нашому поточному вью
    }
    
}


//MARK: - UITableViewDelegate & DataSource
extension AlarmVC: UITableViewDelegate, UITableViewDataSource {
    
    //функція яка повертає наші делегати для таблички
    private func applyDelegates() {
        alarmTable.delegate = self
        alarmTable.dataSource = self
    }
    
    
    // number of section
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count //передаємо наші секціі - count нашого масива із секціями
    }
    
    // title for section// відображає заголовки наших секцій - тобто приймає Int як індекс секції і повертає String? - саме велью певного індекса у масиві секцій
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    //will display heade view //певні налаштування для секцій. Тут ми робимо хедер - HeaderView, тобто він є UIView, але нам треба його закастити як TableViewHeaderFooterView, тому що звичайний View туди не буде працювати
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let header = view as? UITableViewHeaderFooterView else { return } //тобто тут кастимо хедер як UITableViewHeaderFooterView
        
        header.textLabel?.font = UIFont.systemFont(ofSize: 22, weight: .medium) //тепер можемо змінити шрифтна більний (бо заголовки у секцій завжди дуже дрібного шрифту)
        header.textLabel?.textColor = .white //колір задаємо
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y - 5, width: 300, height: header.bounds.height) //і розтягуємо фрейм, так як він стандартно під той стандартний малешький розмір шрифта. Щоб вліз наш збільшений шрифт.
        
    }
    
    // number of rows in section //обов'язковий - для делегатів таблички //вказуємо кількість рядків у секції. Тут є параметр секція. так як у нас всього дві секції - ми прописуємо певну умову
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { //вказуємо якщо секція під індексом 0
            return 1 //то повертаємо 1 рядок. Це так працює, коли в нас нічого не має у секції Інше
        } else { //якщо не лише 0
            return alarms.count //то додаються і ішні, що є у масиві секцій - тобто секція Інше з'явиться і додадуться встановлені будильники
        }
    }
    
    // can edit rows //прописуємо, що першу секцію коригувати не можна
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // can't edit rows at section 1 (index 0)
        if indexPath.section == 0 { //тобто секція за індексом 0
            return false //canEditRowAt - false - тобто не можна редагувати
        } else { //усі інші секції
            return true //canEditRowAt - true - тобто можна редагувати
        }
    }
    
    // title for delete btn
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Видалити"
    }
    
    
    // editing styles
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            self.alarms.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
            // using dispatch queue to set editing mode to false after all deleting proccesses will end
            if self.alarms.count == 0 {
                DispatchQueue.main.async {
                    self.alarmTable.isEditing = false
                    self.navigationItem.leftBarButtonItem?.title = "Змінити"
                }
            }
            
        default:
            return
        }
        
        
    }
    
    //cell for row at //обов'язковий - для передачі комірки у таблицю.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //так як ми маємо 2 секції в нашій табличці, тож реєструємо 2 комірки у таблиці. SmartAlarmTableViewCell і AlarmTableViewCell
        if indexPath.section == 0 { //у indexPath також є метод section, щоб дізнатися на якій ми секції (тобто не тільки який зараз рядок, а яка секція) і тому ми можемо вказати, якщо секція indexPath буде за індексом 0 то ми робимо 1 комірку - нижче прописуємо яку саме. Ми її окремо створили у файлі клас SmartAlarmTableViewCell. І повертаємо її.

            guard let cell = tableView.dequeueReusableCell(withIdentifier: SmartAlarmTableViewCell.identifier) as? SmartAlarmTableViewCell else { return UITableViewCell()}
            return cell

        } else { //якщо усе інше, то додаються будильники і з'являється інша наша секція

            guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmTableViewCell.identifier) as? AlarmTableViewCell else { return UITableViewCell()}

            let model = alarms[indexPath.row] //створюємо модель по індекс пасу з нашого масиву (для даних, що передаються з масиву)
            
            // hiding switch when editing mode is on and add accessoryType
            if tableView.isEditing {
                cell.isSwitchHidden(hideStatus: true)
                cell.editingAccessoryType = .disclosureIndicator
                
            } else {
                cell.isSwitchHidden(hideStatus: false)
            }
            
            cell.configure(with: model) //та конфігуруємо
            
            return cell //і повертаємо комірку

        }
        
    }
    
}
