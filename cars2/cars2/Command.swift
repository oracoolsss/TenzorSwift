enum Command: String {
  case print = "print"
  case add = "add"
  case remove = "rm"
  case exit = "exit"
  
  static let commands: [Command] = [.print, .add, .remove, .exit]
}
