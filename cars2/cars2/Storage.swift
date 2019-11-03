import Foundation

private let fileURL = URL(fileURLWithPath: "./cars.txt")

class Storage {
  internal private(set) var cars: [Car] = []
  
  func addCar(_ car: Car) {
    cars.append(car)
  }
  
  func addCar(_ car: Car,_ ind: Int) {
    if ind >= 0 {
      cars.insert(car, at: min(ind, cars.count))
    }
    else {
      print("wrong index")
    }
  }
  
  func removeCar(_ carForRemove: Car) {
    cars.removeAll { car in
      return car == carForRemove
    }
  }
  
  func removeCar(_ index: Int) {
    cars.remove(at: index)
  }
  
  func removeCar(_ param: String) {
    cars.removeAll { car in
      return car.name.contains(param) || car.model.contains(param) || String(car.year).contains(param)
    }
  }
  
  func save() {
    guard let data = try? JSONEncoder().encode(cars) else {
      fatalError("Can't encode data")
    }
    try? data.write(to: fileURL)
  }
  
  func load() {
    guard let data = try? Data(contentsOf: fileURL) else {
      print("there is no any data in folder")
      return
    }
    
    guard let carsData = try? JSONDecoder().decode([Car].self, from: data) else {
      print("wrong data")
      return
    }
    cars = carsData
  }
  
  
}
