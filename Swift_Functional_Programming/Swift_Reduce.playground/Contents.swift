//: Playground - noun: a place where people can play

import UIKit

//1. Find the sum of array

let numbers = [1,2,3,4,5,6,7,8]

let sumOfNumbers = numbers.reduce(0) { (total, number) in
    total + number
}
print(sumOfNumbers)

// 2 Sum of array by using dollar notation in swift for arguments

let numbersSum = numbers.reduce(0, combine: {  $0 + $1
})

print(numbersSum)

//3 Some of array by using operator only
let sum = numbers.reduce(0, combine: +)

//4. Find the multiplication of array
let multiplication = numbers.reduce(1, combine: *)



//5. My custom reduce implementation

func myReduce<T,U>(initial:U,source:[T],combine:(U,T)->U)->U{
    var current = initial
    
    for item in source{
        
        current = combine(current,item)
    }
    
    return current
    
}

let numberSum = myReduce(0, source: numbers) { (total, number) in
    total + number
}
print(numberSum)



//6. Custom reduce implementation using extension


extension Array{
    
    func myReduce<T,U>(initial:U, combiner:(U,T)->U)->U{
        
        var current = initial
        
        for item in self{
            current = combiner(current ,item as! T)
        }
     
        return current
    }
}

let myReduceSum = numbers.myReduce(0, combiner: +)


// 7. convert array into comman separated string without functional programming

let verticals = [ "iOS", "Android", "Grails","CQ"]

var commaSeparatedString = ""

for vertical in verticals{
    commaSeparatedString += vertical
    
    if vertical != verticals.last{
        commaSeparatedString += ", "
    }
}

print(commaSeparatedString)

// 8. convert array into comman separated string using reduce functional function

let commaSeparatedVerticals = verticals.reduce(""){ total,vertical in
    let maybeComma = (vertical == verticals.last) ? "" : ", "
    return "\(total)\(vertical)\(maybeComma)"
}

print(commaSeparatedVerticals)


// 9. Custom functional program
//Note: You can not add comparator operator if type casting is not equatable type
// Note : you can use joinWithSeparator:"" to achieve this

func join<T:Equatable>(source:[T], separator:String)->String{
    return source.reduce("", combine: { (total, objc) in
        let maybeSeparator = (objc == source.last) ? "" : separator
        return "\(total)\(objc)\(maybeSeparator)"
    })
}

let fruits = [ "Apples", "Bananas", "Cherries" ]
let commaSeparatedFruits = join(fruits, separator: ", ")


//10: reduce with custom model (Find the sum of ages of all persons)

struct Person {
    let name: String
    let age: Int
}

let people = [
    Person(name: "Katie",  age: 23),
    Person(name: "Bob",    age: 21),
    Person(name: "Rachel", age: 33),
    Person(name: "John",   age: 27),
    Person(name: "Megan",  age: 15)
]

let sumOfAges = people.reduce(0, combine: {$0 + $1.age})
print(sumOfAges)



//11. Convert  2D to 1D

let arrayOfArrays = [
    [ 0, 1, 2 ],
    [ 3, 4, 5 ],
    [ 6, 7, 8 ]
]

let reduceTo1D: [Int] = arrayOfArrays.reduce([]) {
    result, row in
    return result + row
}

print(reduceTo1D)



//12. Check downloading state

struct DownloadingState {
    let title: String
    let downloaded: Bool
}

let downloadingState = [
    DownloadingState(title: "Objective-C", downloaded: true),
    DownloadingState(title: "Swift",       downloaded: true),
    DownloadingState(title: "Scala",     downloaded: false),
    DownloadingState(title: "Ruby",        downloaded: true),
    DownloadingState(title: "Java 8",        downloaded: true)
]


let state = downloadingState.reduce(true){
    return $0 && $1.downloaded
}

print(state)
