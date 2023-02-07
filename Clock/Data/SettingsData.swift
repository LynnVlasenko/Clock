//
//  SettingsData.swift
//  Clock
//
//  Created by Алина Власенко on 07.02.2023.
//

import Foundation


class SettingsData {
    static let shared = SettingsData() //створюємо сингелтон, для зручного доступу до наший даних у вьюшці
    
    //Прописуємо в нашу модель значення для таблички додавання будильника
    private let alarmSetting = [
        Setting(title: "Повторювати", property: SettingsOptions.label, propertyValue: "Ніколи", accesorry: true),
        Setting(title: "Назва", property: SettingsOptions.textField, propertyValue: "Сигнал", accesorry: false),
        Setting(title: "Звук", property: SettingsOptions.label, propertyValue: "Alarm", accesorry: true),
        Setting(title: "Відкласти", property: SettingsOptions.uiSwitch, propertyValue: "on", accesorry: false)
    ]
    
    //Прописуємо в нашу модель значення для таблички таймера
    private let timerSettings = [
        Setting(title: "У кінці", property: SettingsOptions.label, propertyValue: "Радар", accesorry: true)
    ]
    
    //повертаємо наші масиви даних через функції
    func getAlarmSettings() -> [Setting] {
        return alarmSetting
    }
    
    func getTimerSettings() -> [Setting] {
        return timerSettings
    }
}
