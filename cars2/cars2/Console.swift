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
    
    print("write yes if you want to add car with special index, write something else if you don't want to do this")
    guard let answer = readLine() else {
      fatalError("Ooops...")
    }
    if answer != "yes" {
      storage.addCar(Car(name: carName, year: carYear, model: carModel))
      return
    }
    
    print("write preferable index")
    while true {
      guard let indexOfStr = readLine(), let index = Int(indexOfStr) else {
        print("Please write correct index")
        continue
      }
      
      if index >= 0 {
        storage.addCar(Car(name: carName, year: carYear, model: carModel), index)
        break
      }
    }
  }
  
  private func removeAtIndex() {
    print("Write index")
    while true {
      guard let carIndexOfStr = readLine(), let carIndex = Int(carIndexOfStr) else {
        print("Please write correct index")
        continue
      }
      
      if(storage.cars.count > carIndex && carIndex >= 0) {
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
                param - to delet car in it's parameter (year, model etc)
                cancel or smth else - cancel operation
                """)
    
    guard let param = readLine() else {
      fatalError("Ooops...")
    }
    switch param {
    case "ind":
      removeAtIndex()
    case "param":
      removeAtParam()
    default:
      print("ok, no == no")
    }
  }
}
