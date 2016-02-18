//: Playground - noun: a place where people can play

import UIKit

var numbers = [1,2,4,5,6,9,10,2,5,4,10]

print(numbers)


// 1 Generics in Swift

//// Let's say you have an integer array and a string array. You have to write a single method printArray that can print all the elements of both arrays. The method should be able to accept both integer arrays or string arrays.


// Start of struct Printer
class Printer<type> {
    // var items:[type]?
    func printArray(items:[type]){
        for item in items{
            print(item)
        }
    }
} // End of struct Printer


let vInt = [1, 2, 3]
let vString = ["Hello", "World"]

Printer<Int>().printArray(vInt)
Printer<String>().printArray(vString)



// 2. Find even numbers from numbers array without using functional programming

func findEvenNumbers(numbers:[Int])->[Int]{
    var evenNumbers = [Int]()
    for item in numbers{
        if item%2 == 0{
            evenNumbers.append(item)
        }
    }
    return evenNumbers
}

print(findEvenNumbers(numbers))


// 3. Find even numbers from numbers array using functional programming

func isEven(number:Int)->Bool{
    return number%2 == 0
}
print(numbers.filter(isEven))


// 4. Implement custom filter functionality & find out even numbers by using custom filter Higher level function

func myFilter<T>(source:[T],predicate:(T)->Bool)->[T]{
    var even = [T]()
    for item in source{
        if predicate(item){
            even.append(item)
        }
    }
    return even
}

let evenNumbers = myFilter(numbers, predicate: { ($0%2==0)})

print(evenNumbers)


// 5. Find all numbers less than 6 from numbers array

let lessThanSixNumbers = numbers.filter({$0<6})
print(lessThanSixNumbers)


// 6. Functional programming in custom objects i.e. structures.

struct Person{
    let ID : Int
    let Name: String
}

var persons = [Person]()

let person1:Person  = Person(ID: 1, Name: "Rock")
let person2:Person  = Person(ID: 5, Name: "Abhi")
let person3:Person  = Person(ID: 2, Name: "Abhayam")
let person4:Person  = Person(ID: 5, Name: "Rastogi")
let person5:Person  = Person(ID: 8, Name: "iOS")
let person6:Person  = Person(ID: 2, Name: "Rock")

persons.append(person1)
persons.append(person2)
persons.append(person3)
persons.append(person4)
persons.append(person5)
persons.append(person6)

// Find person objects having even ID
var filteredPersons = persons.filter({$0.ID%2 == 0})
print(filteredPersons)


//7. Sorted person objects corresponding to IDs & having name = "Rock"


var sortedPersons = persons.sort({$0.ID < $1.ID}).filter({$0.Name == "Rock"})

print(sortedPersons)




//8. Given a string S, find number of words in that string. Space or any of the special characters like " [ ''!_,?.\\@+] " will act as a delimiter.

// Input : He is a very very good boy, isn't he?

// output should be number of words & all words except delimiter

/*
output:
10
He
is
a
very
very
good
boy
isn
t
he
*/

let input = "He is a very very good boy, isn't he?"
let filteredOutput = input.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: " [ ''!_,?.\\@+]")).filter({!$0.isEmpty})

for item in filteredOutput{
    print(item)
}




// 8. print even numbers less than 100

let evens = Array(2..<100).filter({$0 % 2 == 0})
print(evens)


// 9. Create myFilter extension similar to apple's filter higher level funciton

extension Array{
    
    func myFilter<T>(predicate:(T)->Bool)->[T]{
        
        var evenNumbers = [T]()
        
        for element in self{
            
            if predicate(element as! T){
                evenNumbers.append(element as! T)
            }
        }
        
        return evenNumbers
    }
}


//10. print less than 9 numbers using myFilter extension

let lessThan9Numbers = Array(1...20).myFilter( {$0 < 9})
print(lessThan9Numbers)


/*
* Now some weak & strong related examples
*/

// 11

class AnyNormalClass{
    var name:String
    
    init(name:String){
        self.name = name
    }
    deinit{
        print("deinit called of class \(name)")
    }
}

var normalClass:AnyNormalClass? = AnyNormalClass(name: "Normal Class")

normalClass = nil


// 12
class Category{
    let id = 1
    var name:String
    var subCategory:SubCategory?
    init(name:String){
        self.name = name
    }
    
    deinit{
        print("deinit called of class \(name)")
    }
}


class SubCategory{
    let id = 1.1
    var name:String
    var category:Category?
    init(name:String){
        self.name = name
    }
    deinit{
        print("deinit called of class \(name)")
    }
}


var category:Category? = Category(name: "Category")
var subCategory:SubCategory? = SubCategory(name: "SubCategory")
category!.subCategory = subCategory
subCategory!.category = category

category = nil
subCategory = nil


// 13
//Must declare every weak reference as having an optional type because weak references are allowed to have “no value”


class WeakExampleCategory{
    
    var name:String
    var subCategory:WeakExampleSubCategory?
    init(name:String){
        self.name = name
    }
    
    deinit{
        print("deinit called of class \(name)")
    }
}

class WeakExampleSubCategory{
    var name:String
    weak var category:WeakExampleCategory?
    init(name:String){
        self.name = name
    }
    deinit{
        print("deinit called of class \(name)")
    }
}


var weakCategory:WeakExampleCategory? = WeakExampleCategory(name: "Category")
var weakSubCategory:WeakExampleSubCategory? = WeakExampleSubCategory(name: "SubCategory")
weakCategory!.subCategory = weakSubCategory
weakSubCategory!.category = weakCategory

weakSubCategory = nil
weakCategory = nil


// 14

// unowned always have a value .Because of this, an unowned reference is always defined as a nonoptional type.

class User{
    
    var name:String
    var phone:String
    var panCard:PanCard?
    init(name:String,phone:String){
        self.name = name
        self.phone = phone
    }
    
    deinit{
        print("deinit called of class \(name)")
    }
}

class PanCard{
    unowned var user:User
    var carnumber:String
    init(cardnumber:String,user:User){
        self.carnumber = cardnumber
        self.user = user
    }
    deinit{
        print("deinit called of class \(carnumber)")
    }
}


var user:User? = User(name: "abhayam",phone: "991192")
user!.panCard = PanCard(cardnumber: "12323213", user: user!)
user = nil


// 15  both properties should always have a value

class ThirdCaseUser{
    
    var name:String
    var phone:String
    var panCard:ThirdCasePan!
    init(name:String,phone:String){
        self.name = name
        self.phone = phone
    }
    
    deinit{
        print("deinit called of class \(name)")
    }
}

class ThirdCasePan{
    unowned let user:ThirdCaseUser
    var cardnumber:String
    init(cardnumber:String,user:ThirdCaseUser){
        self.cardnumber = cardnumber
        self.user = user
    }
    deinit{
        print("deinit called of class \(cardnumber)")
    }
}

var thirdCaseUser:ThirdCaseUser? = ThirdCaseUser(name: "abhayam",phone: "991192")
 thirdCaseUser?.panCard = ThirdCasePan(cardnumber: "132132131", user: thirdCaseUser!)
thirdCaseUser = nil



// 16 Initializer

class Technology{
    
    var field:String
    
    init(stream:String){
      self.field = "stream is \(stream)"
    }
    
    
    init(techField:String){
        self.field = "tech Field is \(techField)"
    }
}


var technology = Technology(techField: "iOS")
print(technology.field)

var streanTech = Technology(stream: "iOS")
print(streanTech.field)


// 17 Default Values


class DefaultValueClass{
    
    var integer:Int?
    var string:String?
    
}


var defaultValues = DefaultValueClass()
print(defaultValues.integer)


// 18 closure example


class Products{
    
    var name:String?
    var ID:Int
    
    init(name:String?,id:Int){
        self.name = name
        self.ID = id
    }
    
    lazy var closure:()->String = { [unowned self] in
        
        return self.name == nil ? "default text" : self.name!
    }
    
    deinit{
        print("deinitialization of \(name)")
    }
    
}

var product:Products? = Products(name: nil, id: 1)

print(product!.closure())
product = nil
