let storage = Storage()
storage.load()

let console: Console = Console(storage: storage)
console.run()

storage.save()
