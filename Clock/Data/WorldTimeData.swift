//
//  WorldTimeData.swift
//  Clock
//
//  Created by Алина Власенко on 01.02.2023.
//

import Foundation


class WorldTimeData {
    
    static let shared = WorldTimeData() //це сінгелтон він допомагає передати зразок в одному місці і потім викликати одразу метод для певної змінної. Через WorldTimeData.shared. далі -> властивості чи медоди будуть доступні для передачі у змінну чи ще кудить, куди треба передати певні дані з класу чи структури. Це для того щоб кожного разу не створювати об'єкт для сласу, щоб передати з нього дані.
    
    
    //Масив даних який передає дані для кожної константи яка сворена у структурі (в моделі) WorldTime.
    private let timesArray = [
        WorldTime(difference: "Сьогодні, -10 Г", city: "Сан-Франциско", region: "США", time: "06:06"),
        WorldTime(difference: "Сьогодні, -10 Г", city: "Лос-Анджелес", region: "США", time: "06:06"),
        WorldTime(difference: "Сьогодні, -2 Г", city: "Дублін", region: "Ірландія", time: "14:06"),
        WorldTime(difference: "Завтра, +9 Г", city: "Мельбурн", region: "Австралія", time: "01:06"),
        WorldTime(difference: "Сьогодні, -10 Г", city: "Сан-Франциско", region: "США", time: "06:06"),
        WorldTime(difference: "Сьогодні, -10 Г", city: "Лос-Анджелес", region: "США", time: "06:06"),
        WorldTime(difference: "Сьогодні, -2 Г", city: "Дублін", region: "Ірландія", time: "14:06"),
        WorldTime(difference: "Завтра, +9 Г", city: "Мельбурн", region: "Австралія", time: "01:06"),
        WorldTime(difference: "Сьогодні, -10 Г", city: "Сан-Франциско", region: "США", time: "06:06"),
        WorldTime(difference: "Сьогодні, -10 Г", city: "Лос-Анджелес", region: "США", time: "06:06"),
        WorldTime(difference: "Сьогодні, -2 Г", city: "Дублін", region: "Ірландія", time: "14:06"),
        WorldTime(difference: "Завтра, +9 Г", city: "Мельбурн", region: "Австралія", time: "01:06"),
        WorldTime(difference: "Сьогодні, -10 Г", city: "Сан-Франциско", region: "США", time: "06:06"),
        WorldTime(difference: "Сьогодні, -10 Г", city: "Лос-Анджелес", region: "США", time: "06:06"),
        WorldTime(difference: "Сьогодні, -2 Г", city: "Дублін", region: "Ірландія", time: "14:06"),
        WorldTime(difference: "Завтра, +9 Г", city: "Мельбурн", region: "Австралія", time: "01:06"),
        WorldTime(difference: "Сьогодні, -10 Г", city: "Сан-Франциско", region: "США", time: "06:06"),
        WorldTime(difference: "Сьогодні, -10 Г", city: "Лос-Анджелес", region: "США", time: "06:06"),
        WorldTime(difference: "Сьогодні, -2 Г", city: "Дублін", region: "Ірландія", time: "14:06"),
        WorldTime(difference: "Завтра, +9 Г", city: "Мельбурн", region: "Австралія", time: "01:06"),
        WorldTime(difference: "Сьогодні, -10 Г", city: "Сан-Франциско", region: "США", time: "06:06"),
        WorldTime(difference: "Сьогодні, -10 Г", city: "Лос-Анджелес", region: "США", time: "06:06"),
        WorldTime(difference: "Сьогодні, -2 Г", city: "Дублін", region: "Ірландія", time: "14:06"),
        WorldTime(difference: "Завтра, +9 Г", city: "Мельбурн", region: "Австралія", time: "01:06"),
        WorldTime(difference: "Сьогодні, -10 Г", city: "Сан-Франциско", region: "США", time: "06:06")
    ]
    
    //функція яка повертає масив з типом WorldTime - що відповідає нашому створеному масиву timesArray вище - тож його і буде повертати.
    func timeZone() -> [WorldTime] {
        return timesArray
    }
}
