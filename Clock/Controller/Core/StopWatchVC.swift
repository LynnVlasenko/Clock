//
//  StopWatchVC.swift
//  Clock
//
//  Created by Алина Власенко on 31.01.2023.
//

import UIKit

class StopWatchVC: UIViewController {
    
    //MARK: - Array
    
    private var circles = [Circle]() //створюємо порожній масив з типом нашої моделі Circle, куди будуть зберигатися нові дані з часом кола
    private var circlesCount = 0 //задаємо початкове значення для відліку часу
    
    //MARK: - Timer
    private var timer = Timer() //створюємо таймер за допомогою класу Timer()
    
    //початкові значення для відліку хвилин, секунд та мілісекунд
    private var min = 0
    private var sec = 0
    private var milisec = 0

    //MARK: - UI objects
    private let timeLbl: UILabel = {
        let label = UILabel()
        label.text = "00:00,00"
        label.font = UIFont.systemFont(ofSize: 90, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let circleView_1: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        view.layer.cornerRadius = view.frame.width / 2.0
        view.backgroundColor = UIColor(named: "SpecialGreen")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let circleView_2: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        view.layer.cornerRadius = view.frame.width / 2.0
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let startStopBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Старт", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 77, height: 77)
        button.backgroundColor = UIColor(named: "SpecialGreen")
        button.setTitleColor(.systemGreen, for: .normal)
        // action
        button.addTarget(self, action: #selector(startStopAction), for: .touchUpInside)
        //dynamic round corner radius //крута штука
        button.layer.cornerRadius = button.frame.width / 2.0
        button.layer.borderWidth = 2
        button.layer.borderColor = .none
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let resetAndCircleBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Коло", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 77, height: 77)
        button.backgroundColor = .systemGray6
        // action
        button.addTarget(self, action: #selector(resetAndCircleAction), for: .touchUpInside)
        // dynamic corner radius
        button.layer.cornerRadius = button.frame.width / 2.0
        button.layer.borderWidth = 2
        button.layer.borderColor = .none
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let circlesTable: UITableView = {
        let table = UITableView()
        table.register(CircleTableCell.self, forCellReuseIdentifier: CircleTableCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false //відключаємо AutoresizingMask, щоб самим прописувати констрейнти
        table.showsVerticalScrollIndicator = false //прибираємо відображення скрола - срол буде за дотиком просто
        return table
    }()
    
    
    //MARK: - viewDidLoad
    //передаємо у функцію уси нащі вьюшки, констрейни і делегати
    override func viewDidLoad() {
        super.viewDidLoad()
        // bg color
        view.backgroundColor = .systemBackground
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // apply delegates
        applyDelegates()
    }
    
    
    //MARK: - Add subviews
    //Додаємо на наше вью усі наші сабвьюшки
    private func addSubviews() {
        view.addSubview(timeLbl)
        view.addSubview(resetAndCircleBtn)
        circleView_1.addSubview(startStopBtn)
        view.addSubview(circleView_1)
        circleView_2.addSubview(resetAndCircleBtn)
        view.addSubview(circleView_2)
        view.addSubview(circlesTable)
    }
    
    //MARK: - Actions
    @objc private func startStopAction() {
        
        guard let title = startStopBtn.title(for: .normal) else { return } //створюємо функцію куди передаються тайтли кнопки startStop
        
        switch title {
        case "Старт": //коли тайтл Старт, який задано початково, то при натисканні буде насупне:
            
             
            if circles.count == 0 { //Коли додалося до створеного вище порожнього масиву circles перше значення з індексом 0
                circlesCount += 1 //додаємо 1 до circlesCount - нашої відправної точки для відліку.
                let model = Circle(circle: circlesCount, time: "00:00,00") //створюємо модель і передаємо значення(оновлений circlesCount і поки що лейблу для часу нульову) які маємо передати у комірку з Колом
                circles.append(model) //додаємо оновлені значення у масив
                print("ADDED")
                circlesTable.reloadData() //оновлюємо табличку
            }
            
            // ui changes //змінюємо вигляд кнопки на кнопку Стоп
            startStopBtn.setTitle("Стоп", for: .normal)
            startStopBtn.setTitleColor(.systemRed, for: .normal)
            startStopBtn.backgroundColor = UIColor(named: "SpecialRed")
            circleView_1.backgroundColor = UIColor(named: "SpecialRed")
            circleView_2.backgroundColor = .systemGray4
            resetAndCircleBtn.backgroundColor = .systemGray4
            resetAndCircleBtn.setTitleColor(.white, for: .normal)
            
            // if resetBtn title == reset //Змінюємо вигляд іншої кнопки
            if resetAndCircleBtn.title(for: .normal) == "На нуль" {
                resetAndCircleBtn.backgroundColor = .systemGray4
                resetAndCircleBtn.setTitleColor(.white, for: .normal)
                resetAndCircleBtn.setTitle("Коло", for: .normal)
            }
            // logic //Вмикаємо роботу секундоміра //як працює прописано у функції timerAction яку передаємо у селектор
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            
            
        case "Стоп": //інший кейс, коли натискаємо на кнопку startStop з тайтлом Стоп, то відбувається інше:
            // ui changes // змінюємо вигляд обох кнопок
            print("reset")
            circleView_1.backgroundColor = UIColor(named: "SpecialGreen")
            startStopBtn.setTitle("Старт", for: .normal)
            startStopBtn.backgroundColor = UIColor(named: "SpecialGreen")
            startStopBtn.setTitleColor(.systemGreen, for: .normal)
            resetAndCircleBtn.setTitle("На нуль", for: .normal)
            // logic
            timer.invalidate() //таймер призупиняється, але не скидається до 0
            
        default:
            return
        }
    }
    
    @objc private func resetAndCircleAction() { //налаштування до кнопки - На нуль і Коло
        guard let title = resetAndCircleBtn.title(for: .normal) else { return } //створюємо функцію куди передаються тайтли кнопки resetAndCircleBtn
        
        switch title {
        case "Коло": //коли натискаємо кнопку Коло:
            
            circlesCount += 1 //додається значення до відправної точки
            
            let model = Circle(circle: circlesCount, time: "") //створюємо модель і передаємо значення(оновлений circlesCount і порожню лейблу для часу) які маємо передати у комірку з Колом
            circles.append(model) //додаємо дані у масив зі значеннями
            
            //намагалися зробити щоб додавалося коло на верх таблички, я так розумію
//                circlesTable.beginUpdates()
//                circlesTable.moveRow(at: IndexPath(row: circles.count - 1, section: 0), to: IndexPath(row: 0, section: 0))
//                circlesTable.endUpdates()
            
            
        case "На нуль": //коли натискаємо на кнопку На нуль:
            // ui changes //змінюємо кнопку коло на початковий вигляд
            resetAndCircleBtn.setTitle("Коло", for: .normal)
            resetAndCircleBtn.setTitleColor(.systemGray, for: .normal)
            resetAndCircleBtn.backgroundColor = .systemGray6
            circleView_2.backgroundColor = .systemGray6
            // logic
            timeLbl.text = "00:00,00" //відображаємо почасковій стан секундоміра - онуляємо його по факту таким чином
            min = 0 //онуляємо значення хвилин
            sec = 0 //онуляємо значення секунд
            milisec = 0 //онуляємо значення мілісекунд

        default:
            return
        }
    }
    
    @objc private func timerAction() { //Прописуємо функціонал роботи таймера(функція яку вище передалі у селектор таймера)
                        
        let time = convertTimeToString() //створюємо константу з функцією яка описує роботу таймера (вона знизу)
            
        guard var model = circles.last else { return } //створюємо модель в яку передаємо останнє значення у масиві, передане після натискання Стоп
        model.updateTime(with: time) //типу оновлюємо значення часу від якого знову почнемо відлік при натисканні Старт - функція прописана у файлі Circle
        circles.removeLast() //перезапускаємо останнє значення
        circles.append(model) //додаємо у масив
        circlesTable.reloadData() //оновлюємо табличку
        milisec += 1 //додаємо мілісекунди
    }
    
    //функція яка описує роботу таймера, яку передали вище у timerAction()
    private func convertTimeToString() -> String {
        // works
        if milisec > 99 { //якщо мілісекунди добігають до 99
            milisec = 0 //обнулити мілісекунди
            sec += 1 //додати 1 секунду
            if sec > 59 { //коли секунди добігли до 59
                sec = 0 //онулити секунди
                min += 1 //додати хвилвнку
            }
        }
        //створюємо змінну яка оновлює вигляд таймера і додає формат двозначного числа і додає 0 попереду значення таймера коли він лише з одною цифрою від 1 до 9
        var timeString = ""
        timeString += String(format: "%02d", min)
        timeString += ":"
        timeString += String(format: "%02d", sec)
        timeString += ","
        timeString += String(format: "%02d", milisec)
        
        timeLbl.text = timeString //записуємо значення и нашу лейблу з часом
        return timeString //повертаємо стрінгу з поточним часом
    }
    

    //MARK: - Apply constraints
    private func applyConstraints() {
        
        let timeLblConstraints = [
            timeLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            timeLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            timeLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        ]
        
        let circleView_1Constraints = [
            circleView_1.topAnchor.constraint(equalTo: timeLbl.bottomAnchor, constant: 100),
            circleView_1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            circleView_1.widthAnchor.constraint(equalToConstant: 83),
            circleView_1.heightAnchor.constraint(equalToConstant: 83)
        ]
        
        let startStopBtnConstraints = [
            startStopBtn.widthAnchor.constraint(equalToConstant: 80),
            startStopBtn.heightAnchor.constraint(equalToConstant: 80),
            startStopBtn.centerXAnchor.constraint(equalTo: circleView_1.centerXAnchor),
            startStopBtn.centerYAnchor.constraint(equalTo: circleView_1.centerYAnchor)
        ]
        
        let cirleView_2Constraints = [
            circleView_2.centerYAnchor.constraint(equalTo: circleView_1.centerYAnchor),
            circleView_2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            circleView_2.widthAnchor.constraint(equalToConstant: 83),
            circleView_2.heightAnchor.constraint(equalToConstant: 83)
        ]
        
        let resetAndCircleBtnConstraints = [
            resetAndCircleBtn.widthAnchor.constraint(equalToConstant: 80),
            resetAndCircleBtn.heightAnchor.constraint(equalToConstant: 80),
            resetAndCircleBtn.centerXAnchor.constraint(equalTo: circleView_2.centerXAnchor),
            resetAndCircleBtn.centerYAnchor.constraint(equalTo: circleView_2.centerYAnchor)
        ]
        
        let circlesTableConstraints = [
            circlesTable.topAnchor.constraint(equalTo: startStopBtn.bottomAnchor, constant: 30),
            circlesTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            circlesTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            circlesTable.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        NSLayoutConstraint.activate(timeLblConstraints)
        NSLayoutConstraint.activate(startStopBtnConstraints)
        NSLayoutConstraint.activate(circleView_1Constraints)
        NSLayoutConstraint.activate(cirleView_2Constraints)
        NSLayoutConstraint.activate(resetAndCircleBtnConstraints)
        NSLayoutConstraint.activate(circlesTableConstraints)
    }
}


//MARK: - UITableViewDelegate & DataSource
//прописуємо наші делегати для таблички
extension StopWatchVC: UITableViewDelegate, UITableViewDataSource {
    
    private func applyDelegates() {
        circlesTable.delegate = self
        circlesTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return circles.count //передаємо кількість рядкив відповідну до кількості значень у масиві
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CircleTableCell.identifier) as? CircleTableCell //передаємо нашу комірку
        else { return UITableViewCell() }
        
        let model = circles[indexPath.row] //створюємо модель на основі indexPath
        
        cell.configure(with: model) //конфігуруємо значення для моделі, які передаються у функції configure(with model: Circle) у файлі нашої комірки, яку передаємо.
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
}
