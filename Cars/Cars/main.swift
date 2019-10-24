//
//  main.swift
//  Cars
//
//  Created by oracool on 24/10/2019.
//  Copyright © 2019 oracool. All rights reserved.
//

import Foundation

enum Command: String {
    case print = "print"
    case add = "add"
    case remove = "rm"
    case exit = "exit"
}

var carList: [String] = []

func printCarList() {
    print("car list:")
    for car in carList{
        print("\(car), ")
    }
}

func addCar() {
    guard let carStr = readLine() else {
        print("error")
        return
    }
    carList.append(carStr)
}

func removeCar() {
    guard let carStr = readLine() else {
        print("error")
        return
    }
    let index = carList.lastIndex(of: carStr) ?? -1
    if index >= 0 {
        carList.remove(at: index)
    }
}


var isWorked: Bool = true
while isWorked {
    print("Write command:")
    guard let commandOfStr = readLine() else {
        fatalError("Ooops...")
    }
    guard let command = Command(rawValue: commandOfStr) else {
        print("Please write correct command: ['exit', 'add', 'rm', 'print']")
        continue
    }
    
    //print("Your write command: \(command.rawValue) \(command)")
    
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
