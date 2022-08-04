import Cocoa

var id = "farid"
let programmerName = id.capitalized
var nickname = "Fafa"

let i = 1
let x = 0.2
let pi = 3.14

var isAwesome = false

let population = 1_000_000
let stringWithQuotes = "\"Quotes\" within \"quotes\""
let multiLineString = """
What a long string this is, isn't it?
Well, that's quite enough for now.
Goodbye!
"""

let s1 = "Haters"
let s2 = "hate"

print(Double(i) + x)
print(i + Int(x))
print("My name is \(programmerName.uppercased())")
print(pi)
print(population)
print(multiLineString)
print(multiLineString.count)
print(population.isMultiple(of: 5 ))
print("pi times 2 is \(pi * 2)")
print(programmerName.hasPrefix("Far"))
print(programmerName.hasSuffix("id\n"))
print(!programmerName.hasSuffix("id "))
print(isAwesome)
isAwesome.toggle()
print(isAwesome)
print(s1 + " gonna " + s2)

var message = "\(nickname) hates \(s1.lowercased())"
print(message)


var names = ["Alice", "Bob"]
var ages = [80, 1, 18, 8]
var heights = [160.8, 164.4, 165 ]
print(ages.sorted())
print(names.reversed())

print(names)
print(names[1])

names.append("Charlie")
print(names[2])
print(names.count)
names.removeAll()
heights.remove(at: 0 )


var scores = Array<Int>()
scores.append(40)

var beatles = [String]()
beatles.append("John")
var bool1 = beatles.contains("John")
print(beatles.contains("Jean"))

var cities: [String] = ["London", "Paris", "New York"]

var employee = [
    "name": "Abbie Ziegler",
    "job": "Janitor"
]
print(employee)
employee["job"] = "Astronaut"
print(employee["name", default: "Unknown"])
print(employee["id", default: ""])
print(employee["age"])
let s3 = "job"
print(employee[s3])

var olympics = [Int: String]()
olympics[2021] = "Tokyo"

var flowerSet = Set<String>()
flowerSet.insert("Tulip")
flowerSet.insert("China Pink")

var dieSides = ([1, 2, 3, 4, 5, 6])
print(dieSides)

// Enum basics
enum Weekday: Comparable {
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
}
var workDay = Weekday.Monday
workDay = .Friday

if workDay >= .Friday {
    print("It is at least Friday (maybe even Saturday or Sunday).")
} else if workDay != .Monday {
    print("It's not Friday yet. But hey, at least it's not Monday, amirite?")
} else {
    print("Dammit, it's Monday.")
}

let surname: String = "Lasso"
let score: Double = 0
//But NOT:
//let score: Int = 0.0
var isAuthenticated: Bool = true
var albums: [String] = [String]()
var countries: [String] = []

if !surname.isEmpty && isAuthenticated {
    print("Welcome \(surname)-san!")
}

enum UIStyle {
    case light, dark, system
}
var style: UIStyle = .system

let username: String
// Much later...
username = "sftabata"

let arr1: [String] = ["just", "a", "collection", "of", "random", "words", "and", "words", "and", "more", "words"]
print(arr1.count)
let set1: Set<String> = Set(arr1)
print(set1.count)

var dict1: [String:Weekday] = Dictionary()
dict1["Start"] = Weekday.Tuesday
print(dict1)

var dict2 = Dictionary<String, Int>()
/* Assign later */

//Enum Raw values
enum Planet: Int {
    case Mercury = 1
    case Venus
    case Earth
    case Mars
}
let ourPlanet = Planet(rawValue: 3)

// Enum Associated values
enum State {
    case bored
    case walking(to: String)
    case singing(volume: Int)
    case talking(topic: String)
}
var charState: State = .walking(to: "The Mall")

// Tuples
var name = (first: "Farid", last: "Tabatabaie")
print(name.0)
print(name.last)

// Switch Statement
switch charState {
case .walking:
    print("Run, Forrest, run!")
case .singing:
    print("Beautiful voice!")
case .talking:
    print("Keep it down, please.")
default:
    print("Unknown State")
}

let day = 5
print("My true love gave to me:")
switch day {
case 5:
    print("Five gold rings...")
    fallthrough
case 4:
    print("Four calling birds...")
    fallthrough
case 3:
    print("Three French hens...")
    fallthrough
case 2:
    print("Two turle doves...")
    fallthrough
case 1:
    print("A partridge in a pear tree.")
default:
    print("Nothing!")
}

// Ternary conditional operator
let age = 19
let canVote = age > 18 ? "Yes" : "No"
print(canVote)

// Ranges
for _ in arr1 {
    print("A word was encountered")
}
for i in 1...5 {
    print("\(i) is \(i.isMultiple(of: 2) ? "" : "NOT") a multiple of 2.")
}
for j in 1..<3 {
    print("\(j) is smaller than 3")
}
// Random

var k = Int.random(in: 1...100)
var z = Double.random(in: 1...1000)
var roll = 0
while roll != 20 {
    roll = Int.random(in: 1...20)
    print("I rolled a \(roll).")
}
print("Yay! Critical hit!")

func getUser(first: String, last: String) -> (firstName: String, lastName: String) {
    (firstName: first.capitalized, lastName: last.capitalized)
    // If it's a one-line function, "return" not required
    // When returning tuples, labels can be omitted. (i.e. "firstName: " and "lastName: " are not required above).
    // Lone "return" is acceptable when there are no return values, but not required.
    // Also labels can be omitted altogether. Use tuple indices instead in that case.
}

let user = getUser(first: "taylor", last:"swift")
print(user.lastName)
// Could also do:
// (firstName, lastName) = getUser(first: "taylor", last:"swift")

// Hiding external argument names
func isUppercase(_ string: String) -> Bool {
    string == string.uppercased()
}
print(isUppercase("HELLO! "))

// Specifying secondary external argument names
func printTimesTable(for number: Int) {
    // Because "for" is a keyword, we couldn't have used it internally inside the loop here:
    for i in 1..<10 {
        print("\(number) times \(i) is \(i * number)")
    }
}
printTimesTable(for: 9)

let height = 10
let width = 20
height < width  // Valid. But what's the point?

// Labaled loops:
let numbers = 1...100
outerLoop: for number1 in numbers {
    for number2 in numbers {
        if number1 == number2 && number1 * number2 == 144 {
            print("Found sqrt(144): \(number1)")
            break outerLoop
        }
    }
}

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]
luckyNumbers.filter({$0 % 2 != 0}).sorted().map({"\($0) is a lucky number"}).map({print($0)})


struct Cabinet {
    var height: Double
    var width: Double
    var area: Double
    init (itemHeight: Double, itemWidth: Double) {
        height = itemHeight
        width = itemWidth
        area = height * width
    }
}
let drawers = Cabinet(itemHeight: 1, itemWidth: 1.0)


// Checkpoint 6, I think?
struct Car {
    let model: String
    let numSeats: Int
    private(set) var currentGear: Int {
        willSet {
            print("About to shift gears from \(currentGear)...")
        }
        didSet {
            print("Shifted gears to \(currentGear)...")
        }
    }
    
    mutating func changeGear(to newGear: Int) -> Bool {
        if newGear > 0 && newGear <= 10 {
            currentGear = newGear
            return true
        }
        return false
    }
}

var myCar = Car(model: "Audi R8", numSeats: 2, currentGear: 1)
print(myCar.currentGear)
myCar.changeGear(to: 2)
print(myCar.currentGear)


// Checkpoint 7
class Animal {
    let legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    func speak() {
        print("Bark!")
    }
}

class Cat: Animal {
    var isTame: Bool
    
    init(isTame: Bool, legs: Int) {
        self.isTame = isTame
        super.init(legs: legs)
    }
    
    func speak() {
        print("Meow!")
    }
}

class Corgi: Dog {
    override func speak() {
        print("Woof!")
    }
}

class Poodle: Dog {
    override func speak() {
        print("Bow wow!")
    }
}

class Persian: Cat {
    override func speak() {
        print("Purr!")
    }
}

class Lion: Cat {
    override func speak() {
        print("Roar!")
    }
}

let cookie = Corgi(legs: 4)
let tama = Persian(isTame: true, legs: 4)


// Checkpoint 8
protocol Building {
    var numRooms: Int {get set}
    var cost: Int {get set}
    var agent: String {get set}
    func summarize()
}

struct House: Building {
    var numRooms: Int
    var cost: Int
    var agent: String
    
    func summarize() {
        print("This house cost $\(cost) and has \(numRooms) rooms. The person in charge is \(agent).")
    }
}

struct Office: Building {
    var numRooms: Int
    var cost: Int
    var agent: String
    
    func summarize() {
        print("This office cost $\(cost) and has \(numRooms) rooms. The person in charge is \(agent).")
    }
}

var newHouse = House(numRooms: 4, cost: 500_000, agent: "Jim Bolton")
newHouse.summarize()

let shoppingList = ["eggs", "tomatoes", "grapes"]
let firstItem = shoppingList.first?.appending(" are on my shopping list")


enum PasswordError: Error {
    case obvious
    case tooShort
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    return true
}

do {
    try checkPassword("password")
    print("That password is ok.")
} catch {
    print("You can't use that password.")
}

// "Optional try"
if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("D'oh.")
}

try! checkPassword("iknowitwontfail")
print("OK!")
// But the following will CRASH:
// try! checkPassword("password")

// Checkpoint 9
func checkpointNine(for array: [Int]?) -> Int {
    array?.randomElement() ?? Int.random(in: 1...100)
}
