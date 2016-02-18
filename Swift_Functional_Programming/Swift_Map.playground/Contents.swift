//: Playground - noun: a place where people can play

import UIKit


// 1. Map convert money array to dollar array

var moneyArray : [Int] = [1,2,3,34,5,6,7,78,9]
var stringsArray = [String]()

for money in moneyArray {
    stringsArray.append("\(money)$")
}

stringsArray = moneyArray.map({ (value) in
    "\(value)$"
})


// 2. Map with custom objects

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


let ages: [Int] = people.map { return $0.age }
let agesTotal   = ages.reduce(0) { return $0 + $1 }
let averageAge  = Double(agesTotal) / Double(ages.count)


//3. 

/*  Sometimes you want to find the unique values within a particular data set. For example, given a list of `Users` who each have a name and a list of things that they like, we want to obtain a list of all the unique likes between all the `Users`.

We can use a combination of `map()` and `reduce()` to achieve this.

First we `map()` the users to their their likes, giving us an array of array's containg the likes.
Next we flatten that list into a single array of likes using the flatten function we wrote earlier.
Now we have our list, but it contains duplicated, so we ca apply `reduce()` to the list with an initial value of an empty set, and the reduce function will add each object to set.
Because sets only contain unique objects, we end up with a unique list of likes.
*/



struct User {
    let name: String
    let likes: [String]
}

let users = [
    User(name: "John",likes: [ "Food", "Pets", "Race", "Cars" ]),
    User(name: "Gold", likes: [ "Games", "Cars", "Water" ]),
    User(name: "Ronald",likes: [ "Papers", "Winters", "Cars", ]),
    User(name: "Alen",   likes: [ "Glasses", "Cars", "iOS", "Programming" ])
]

let likes2D = users.map({$0.likes})
print(likes2D)


func convert2Dto1D(likes:[[String]])->[String]{
    
    return likes.reduce([], combine: { (result, objc) in
        return result+objc
    })
}

let likesArray = convert2Dto1D(likes2D)

print(likesArray.count)

// 4. reduce likesArray to uniqueLikes

let uniqueLikes = likesArray.reduce(NSSet()) { (result, objc) in
    return result.setByAddingObject(objc)
}

print(uniqueLikes.count)







