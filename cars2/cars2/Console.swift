//
//  Console.swift
//  AutoCatalog
//
//  Created by Гость on 24/10/2019.
//  Copyright © 2019 sia. All rights reserved.
//

class Console {
    private let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    func run() {
        var isWorked: Bool = true
        while isWorked {
            print("Write command:", separator: "", terminator: "")
            guard let commandOfStr = readLine() else {
                fatalError("Ooops...")
            }
            guard let command = Command(rawValue: commandOfStr) else {
                print("Please write correct command: [\(allCommandsOfStr())]")
                continue
            }
            
            switch command {
            case .exit:
                isWorked = false
            case .print:
                printCarList()
            case .add:
                addCar()
            case .remove:
                removeCar()
            }
        }
    }
    
    private func allCommandsOfStr() -> String {
        var result: String = ""
        for command in Command.commands {
            result += "'\(command.rawValue)' "
        }
        return result
    }
    
    private func printCarList() {
        if storage.cars.isEmpty {
            print("List is empty")
            return
        }
        
        for (i, car) in storage.cars.enumerated() {
            print("#", i + 1, separator: "")
            print(car)
        }
    }

    private func addCar() {
        print("Write car name: ", separator: "", terminator: "")
        guard let carName = readLine() else {
            fatalError("Ooops...")
        }
        print("Write car year: ", separator: "", terminator: "")
        
        var carYear: Int = 0
        while true {
            guard let carYearOfStr = readLine(), let newCarYear = Int(carYearOfStr) else {
                print("Please write correct year")
                continue
            }
            
            carYear = newCarYear
            break
        }
        
        print("Write car model: ", separator: "", terminator: "")
        guard let carModel = readLine() else {
            fatalError("Ooops...")
        }

        storage.addCar(Car(name: carName, year: carYear, model: carModel))
    }
    
    private func removeAtIndex() {
        print("Write index")
        while true {
            guard let carIndexOfStr = readLine(), let carIndex = Int(carIndexOfStr) else {
                print("Please write correct index")
                continue
            }
            if(storage.cars.count > carIndex) {
                storage.removeCar(carIndex)
            }
            break
        }
    }
    
    private func removeAtParam() {
        print("Write parameter")
        guard let param = readLine() else {
            fatalError("Ooops...")
        }
        storage.removeCar(param)
    }
    
    

    private func removeCar() {
        if storage.cars.isEmpty {
            print("List is empty")
            return
        }
        
        print("""
                write parameter
                ind - to delete car on index
                parameter - to delet car in it's parameter (year, model etc)
                cancel or smth else - cancel operation
                """)
        
        guard let param = readLine() else {
            fatalError("Ooops...")
        }
        switch param {
        case "ind":
            removeAtIndex()
        case "parameter":
            removeAtParam()
        default:
            print("ok, it was your choice")
        }
        // TODO: надо сделать удаление машины по индексу
        // TODO: разделить на две команду удалить
        // TODO: надо сделать удаление машин по совпадению строка может быть в имени годе модели (contains)
        
//        storage.removeCar(Car())
    }
}
