import UIKit

// MARK: 1 Question

let n1: Int = 1

let n2: Float = 2.0

let n3: Double = 3.34

// var result = n1 + n2 + n3

/* В Swift неявное приведение типов между двумя типами данных невозможно.

В приведенном выше коде вы пытаетесь сложить вместе три элемента, каждый из которых представляет собой другой тип данных.

Чтобы исправить это, необходимо преобразовать каждое значение к одному типу данных. Например: */

var result = Double(n1) + Double(n2) + n3

// MARK: 2 Question

var arr1 = [1, 2, 3]
var arr2 = arr1

arr2.append(4)

var len = arr1.count

/*
 Значение len равно 3, т.е. количество элементов в arr1 равно 3. Это происходит потому, что присвоение arr1 к arr2 фактически означает, что копия arr1 присваивается к arr2, поэтому arr1 не затрагивается.

 В Swift все основные типы данных (булевы, целые числа и т. д.), перечисления и структуры по своей природе являются типами значений.

 Массивы тоже являются типами значений. Перемещая тип значения в Swift, вы, по сути, работаете с его копией. Например, при передаче типа значения в качестве аргумента функции создается его копия, поэтому все, что делает функция, не отражается на исходном значении.
*/

// MARK: 3 Question

//var color = UserDefaults.standard.string(forKey: "themeColor")!
//print(color)

// optional binding

if let color = UserDefaults.standard.string(forKey: "themeColor") {
    print(color)
}

// MARK: 4 Question

//func turnTo(direction: String){
//    if direction == "North" {
//        northAction()
//    } else if direction == "East" {
//        eastAction()
//    } else if direction == "South" {
//        southAction()
//    } else if direction == "West" {
//        westAction()
//    } else {
//        print("No valid direction specified")
//    }
//}

// But its not right

//enum Direction {
//    case North
//    case East
//    case South
//    case West
//}
//func turnTo(direction: Direction){
//    switch direction {
//    case .North: northAction()
//    case .East: eastAction()
//    case .South: southAction()
//    case .West: westAction()
//    default:
//        print("No valid direction specified")
//    }
//}

// MARK: 5 Question

//Что такое перечисления (enumerations) в Swift?
//Перечисление (enumeration) - это группа связанных значений.
//
//Перечисления позволяют писать безопасный для типов код.

enum Direction {
   case North
   case East
   case South
   case West
}

//Теперь в своем коде вы можете вызвать, например, Direction.North, вместо того чтобы использовать мистическую строку "North" (которая легко может быть неправильно написана и вызвать раздражающие ошибки).


