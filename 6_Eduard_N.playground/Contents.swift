import UIKit
import Foundation

//Протокол для обеспечения совместимости для последующих сортировок очередей различных типов
protocol ForCompare {
    var priority : Int {get} //приоритет, по которому будет производится сортировка
}

//Создание класса (типа) элементов будущей очереди
class ClassForCompare: ForCompare {
    var priority : Int
    var action: String //название действий, которые будут осуществляться при извлечении элемента с очереди
    init (action:String, priority:Int) {
        self.action=action
        self.priority=priority
    }
}

//Универсальная структура для наполнения очереди, извелечения с нее первого элемента и проверки через Subscripting наличия в очереди элемента с определенным индексом
struct Queue<T:ForCompare> {
    var elements: [T]=[]
    
    mutating func push(_ element:T) {
        elements.append(element)
    }
    mutating func pop() -> T {
        return elements.remove(at: 0)
    }
    subscript(index:Int) ->T? {
        if index>=elements.count {
            return nil}
        return elements[index]
    }
}

//Вывод на экран элементов очереди
func printQueue(massage:String) {
    print(massage)
    for i in queueFirst.elements {
        print("Действие: \(i.action), Приоритет: \(i.priority)")
    }
    print()
}

//Создание пустой очереди
var queueFirst = Queue<ClassForCompare>()

//Создание переменных для последующего внесения их в очередь
var action1 = ClassForCompare(action: "Открыть заслонку №1", priority: 6)
var action2 = ClassForCompare(action: "Открыть заслонку №2", priority: 4)
var action3 = ClassForCompare(action: "Закрыть заслонку №1", priority: 3)
var action4 = ClassForCompare(action: "Закрыть заслонку №2", priority: 1)
var action5 = ClassForCompare(action: "Открыть клапан №1", priority: 5)
var action6 = ClassForCompare(action: "Закрыть клапан №1", priority: 2)

//Заполнение очереди
queueFirst.push(action1)
queueFirst.push(action2)
queueFirst.push(action3)
queueFirst.push(action4)
queueFirst.push(action5)
queueFirst.push(action6)

//Вывод на экран результата
printQueue(massage: "Очередь команд после заполнения:")

//Извлечение (выполнение, удаление) первого элемента в очереди. Вывод результата
queueFirst.pop()
printQueue(massage: "Очередь после извлечения(выполнения) первой команды:")

//Применение метода Sorted для сортировки по убыванию приоритетов. Вывод результата
queueFirst.elements=queueFirst.elements.sorted(by: {$0.priority>$1.priority})
printQueue(massage: "Очередь после сортировки команд по возрастанию приоритетов:")

//Применение метода Map для обнуления всех четных приоритетов. Вывод результата
queueFirst.elements=queueFirst.elements.map({if $0.priority % 2 == 0 {$0.priority=0}; return $0})
printQueue(massage: "Обнуление четных приоритетов в очереди:")

//Проверка Subscripting путем попытки получения доступа к элементу с несуществующим индексом
var numberIndex=7
if queueFirst[numberIndex] !== nil {
    print("Элемент с индексом №\(numberIndex) в очереди существует")
}
else {
    print("Ошибка. Элемента с индексом \(numberIndex) в очереди нет!")
}

