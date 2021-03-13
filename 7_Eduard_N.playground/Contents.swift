import UIKit
import Foundation

//Программа принимает заказы на печать определенного количества листов, выбранного клиентом формата и плотности, определенным цветом краски. При этом в рамках программы определятся есть ли на складе необходимое количество бумаги, вычисляется необходимое количество краски и соответственно проверяется ее наличие. После этого вычисляется стоимость заказа с учетом стоимости листа бумаги нужного формата/плотности и стоимости краски, которая будет расходована на печать. Эта стоимость сравнивается с предоплатой, котрую сделал клиент, если стоимость больше, клиенту выводится разница, которой нехватает для выполнения заказа

//Варианты ошибок
enum ErrorInOrder : String, Error {
    case noPayment = "Заказ не выполнен. Стоимость заказа больше суммы депозита (предоплаты) клиента"
    case noSuchClient = "Заказ не выполнен. У этого клиента нет предоплаты!"
    case outPaper = "Заказ не выполнен. Нет достаточного количества бумаги!"
    case noPaperFormatDensity = "Заказ не выполнен. Нет бумаги нужного формата и плотности!"
    case noColor = "Заказ не выполнен. Нет нужного цвета краски!"
    case outColor = "Заказ не выполнен. Нет достаточного количества краски!"
}

//Форматы бумаги
enum Formats : String {
    case F45x32 = "45x32 cm"
    case F90x64 = "90x64 cm"
    case F100x70 = "100x70 cm"
}

//Плотность бумаги
enum Densities : String {
    case Den70 = "70 грамм/кв.метр"
    case Den90 = "90 грамм/кв.метр"
    case Den130 = "130 грамм/кв.метр"
    case Den175 = "175 грамм/кв.метр"
    case Den250 = "250 грамм/кв.метр"
}

//Варианты цветов краски
enum Colors : String {
    case Blue = "Синяя"
    case Yellow = "Желтая"
    case Red = "Красная"
    case Black = "Черная"
}

//Полный список клиентов
enum AllClients : String {
    case Petrov = "Петров"
    case Sidorov = "Сидоров"
    case Smirnov = "Смирнов"
    case Ivanov = "Иванов"
}

//Структура с колличеством листов на складе, стоимостью одного листа и необходимым количеством краски для его запечатывания
struct Papers {
    var number : Int
    let costOnePaper : Int
    let numberGramColorPerOnePage: Int
    }

//Структура с информацией о конкретном заказе: кто заказыввает, какой формат, на бумаге какой плотности, какой краской печатать и сколько листов
struct Orders {
    let client : AllClients
    let format : Formats
    let density: Densities
    let color : Colors
    let number : Int
}

//Класс, в котором выполнянються основные процедуры
class Printing {
    //Наявный депозит(предоплата) клиентов
    var clientsPayment = [
        AllClients.Petrov : 1200,
        AllClients.Sidorov: 300,
        AllClients.Ivanov : 1200
    ]
    //Фактичесвое наличие бумаги на складе
    var paperInStock = [
        Formats.F45x32 : [Densities.Den130: Papers(number: 100, costOnePaper: 10, numberGramColorPerOnePage: 5),
                          Densities.Den70: Papers(number: 120, costOnePaper: 6, numberGramColorPerOnePage: 5)],
        Formats.F90x64 : [Densities.Den90: Papers(number: 40, costOnePaper: 13,numberGramColorPerOnePage: 20),
                          Densities.Den250: Papers(number: 200, costOnePaper: 33, numberGramColorPerOnePage: 20)],
        Formats.F100x70 : [Densities.Den175: Papers(number: 150, costOnePaper: 29, numberGramColorPerOnePage: 25),
                           Densities.Den70: Papers(number: 140, costOnePaper: 12,numberGramColorPerOnePage: 25)]
      ]
    //Фактическое наличие краски в граммах на складе
    var color = [
        Colors.Blue: 100,
        Colors.Yellow: 150,
        Colors.Black: 200
    ]
    
    //Стоимость одного грамма краски в рублях
    let costOneGramColors = 2
    
    //Функция вывода на экран текущей заполнености склада
    func presentMaterial() {
        print("На данный момент на складе есть в наличии(остались) следующие материалы:")
        for (key1,value1) in paperInStock {
            for (key2, value2) in value1 {
                print("Бумага формата \(key1.rawValue), плотности \(key2.rawValue) в количестве \(value2.number) листов")
            }
        }
        for (key,value) in color {
            print("Краска \(key.rawValue) в количестве \(value) грамм")
        }
        print()
    }
 
    //Основной метод по проверке и печати (извлечении из склада израсходованого материала)
    func allChecksAndPrinting(order : Orders) throws {
        
        //Проверка на наличие нужного формата бумаги, нужной плотности и на наличие нужного количества
        func checkPaper() throws -> Papers {
            guard let checkFormat=paperInStock[order.format] else {
                throw ErrorInOrder.noPaperFormatDensity
            }
            
            guard let checkDensity=checkFormat[order.density] else {
                throw ErrorInOrder.noPaperFormatDensity
            }
            
            guard checkDensity.number>order.number else {
                throw ErrorInOrder.outPaper
            }
            return checkDensity
        }
        
        //Проверка на наличие нужного цвета краски и на нужное количество
        func checkColors(necesnumberGramColors:Int) throws {
            guard let numberGramColors = color[order.color] else {
                throw ErrorInOrder.noColor
            }
            
            guard numberGramColors > necesnumberGramColors else {
                throw ErrorInOrder.outColor
            }
        }
        
        //Проверка есть ли у клиента предоплата и достаточно ли ее
        func checkClientAndPrepaid (cost:Int) throws {
            guard let client=clientsPayment[order.client] else {
                throw ErrorInOrder.noSuchClient
            }
            
            guard client > cost else {
                throw ErrorInOrder.noPayment
            }
        }
        
        //Вычисление стоимости заказа
        func paymentOrder() -> Int {
            let costOrderOnePage=paperInStock[order.format]![order.density]!.costOnePaper
            let costColorOnOnePage = paperInStock[order.format]![order.density]!.numberGramColorPerOnePage*costOneGramColors
            return (costOrderOnePage+costColorOnOnePage)*order.number
        }
        
        //Вывод на экран текущего состояния склада
        presentMaterial()
      
        print("Принят заказ от \(order.client.rawValue) на печать \(order.number) листов на бумаге формата \(order.format.rawValue), плотностью \(order.density.rawValue), краской цвета: \(order.color.rawValue)\n")
        
        //Проверка на отсутствие нужного формата бумаги, нужной плотности и в нужном количестве
        do {
            let _ = try checkPaper()
        }
            catch ErrorInOrder.noPaperFormatDensity {
                print(ErrorInOrder.noPaperFormatDensity.rawValue)
                return
        }
            catch ErrorInOrder.outPaper {
                print(ErrorInOrder.outPaper.rawValue)
                return
        }
        
        //Вычисление необходимого на заказ количества краски
        let nessesaryColorForOrder=paperInStock[order.format]![order.density]!.numberGramColorPerOnePage * order.number
        
        //Проверка наличия нужной краски на складе и в нужном колличестве
        do {
            let _=try checkColors(necesnumberGramColors: nessesaryColorForOrder)
        }
            catch ErrorInOrder.noColor {
                print(ErrorInOrder.noColor.rawValue)
                return
        }
            catch ErrorInOrder.outColor {
                print(ErrorInOrder.outColor.rawValue)
                return
        }
        
        //Проверка платежеспособности клиента
        do {
            let _=try checkClientAndPrepaid(cost: paymentOrder())
        }
            catch ErrorInOrder.noSuchClient {
                print(ErrorInOrder.noSuchClient.rawValue)
                return
        }
            catch ErrorInOrder.noPayment {
                print(ErrorInOrder.noPayment.rawValue, "на \(paymentOrder()-clientsPayment[order.client]!) рублей")
                return
        }
        
        print("\(order.client.rawValue) сделал предоплату в размере \(clientsPayment[order.client]!) рублей. На заказ необходимо \(nessesaryColorForOrder) грамм краски")
        print()
        
        //Внесение изменений в базу имеющегося количества материалов на складе
        paperInStock[order.format]![order.density]!.number -= order.number
        color[order.color]! -= nessesaryColorForOrder
      
        print("Заказ выполнен успешно, его стоимость составила \(paymentOrder()) рублей\n")
        presentMaterial()
    }
    
}
//Создание экземпляра
let printOrder = Printing()

//Проверка и выполнение заказов
let _ = try? printOrder.allChecksAndPrinting(order: .init(client: .Petrov, format: .F45x32, density: .Den175, color: .Black, number: 19))
print("\n-------------------//-----------------------//----------------------//-------------------------//----------------------\n")
let _ = try? printOrder.allChecksAndPrinting(order: .init(client: .Sidorov, format: .F45x32, density: .Den70, color: .Red, number: 20))
print("\n-------------------//-----------------------//----------------------//-------------------------//----------------------\n")
let _ = try? printOrder.allChecksAndPrinting(order: .init(client: .Sidorov, format: .F45x32, density: .Den70, color: .Yellow, number: 11))
