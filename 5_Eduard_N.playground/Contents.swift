import UIKit
import Foundation

//Перечисление с видами автомобилей
enum typeCar {
    case Sportcar
    case TunkCar
}

//Перечисление с моделями автомобилей
enum models {
    case Toyota, Mercedes, BMW, Fiat, Reno, Skoda, Subaru, Mazda, Volkswagen, Kia, Hyunday, Honda
}

//Перечисление с 2 состояниями двигателя - включен/выключен
enum ingineCondition: String {
    case work = "включен"
    case notwork = "выключен"
}

//Перечисление с 2 состояниями окон - открыты/закрыты
enum windowCondition: String {
    case open = "открыты"
    case close = "закрыты"
}

//Перечисление с возможными действиями c автомобилями
enum actionsAllCar {
    //для всех типов автомобилей - запустить/заглушить двигатель,открыть/закрыть окна, выгрузить/загрузить определенный груз
    case startIngine, stopIngine, openWindow, closeWindow
    case unload(cargoSizeInLiters: Int)
    case upload(cargoSizeInLiters: Int)
    
}


//Протокол общий для всех автомобилей
protocol Car {
    var model: models {get}
    var yearProd: Int {get}
    var trunkSizeInLiters: Int {get}
    var presentIngineCond: ingineCondition {get set}
    var presentWindowCond: windowCondition {get set}
    var fullTrunkInLiters: Int {get set}
    
}

extension Car {
    mutating func actionsForAllCars(action: actionsAllCar) {
        switch action {
        case .startIngine:
            presentIngineCond = .work
            print("Двигатель включен!")
        case .stopIngine:
            presentIngineCond = .notwork
            print("Двигатель выключен!")
        case .openWindow:
            presentWindowCond = .open
            print("Окна открыты!")
        case .closeWindow:
            presentWindowCond = .close
            print("Окна закрыты!")
        //Оценка возможности выгрузки/загрузки в зависимости от объема груза
        case .unload(let cargoSizeInLiters):
            if cargoSizeInLiters>(trunkSizeInLiters-fullTrunkInLiters) {
                print("Груз не выгружен. В багажнике(цистерне) автомобиля \(model) нет столько груза!")
            }
            else {
                fullTrunkInLiters = trunkSizeInLiters-cargoSizeInLiters
                print("Груз выгружен!")
            }
        case .upload(let cargoSizeInLiters):
            if cargoSizeInLiters>(trunkSizeInLiters-fullTrunkInLiters) {
                print("Груз не размещен. В багажнике(цистерне) автомобиля \(model) нет места для вашего груза!")
            }
            else {
                fullTrunkInLiters += cargoSizeInLiters
                print("Груз размещен!")
            }
        }
         
    }
}

//Класс для спортивного автомобиля
class SportCar: Car {
    
    let model: models
    let yearProd: Int
    let trunkSizeInLiters: Int
    var presentIngineCond: ingineCondition
    var presentWindowCond: windowCondition
    var fullTrunkInLiters: Int
    
    //Перечисление возможных вариантов спорткаров - с двумя или четырьмя дверями
    enum numDoorSportCar: String {
        case two = "две "
        case four = "четыре"
    }
    
    //Перечисление возможных вариантов спорткаров - с алюминевыми или карбоновыми кузовами (узлами)
    enum materialBodySportCar: String {
        case melal = "алюминевый"
        case carbone = "карбоновый"
    }
    
    //Перечисление возможных вариантов спорткаров - с увеличенными тормозными барабанами или обычными
    enum braikDiscsSportCar: String  {
        case standart = "стандартный"
        case big = "увеличенный"
    }
    
    let numDoorSC: numDoorSportCar
    let materialBodySC: materialBodySportCar
    let braikDiscsSC: braikDiscsSportCar
    
    init(model: models, yearProd: Int,trunkSizeInLiters: Int, presentIngineCond: ingineCondition, presentWindowCond: windowCondition, fullTrunkInLiters: Int, numDoorSC: numDoorSportCar, materialBodySC: materialBodySportCar, braikDiscsSC: braikDiscsSportCar) {
        self.model = model
        self.yearProd=yearProd
        self.trunkSizeInLiters=trunkSizeInLiters
        self.presentIngineCond=presentIngineCond
        self.presentWindowCond=presentWindowCond
        self.fullTrunkInLiters=fullTrunkInLiters
        self.numDoorSC = numDoorSC
        self.materialBodySC = materialBodySC
        self.braikDiscsSC = braikDiscsSC
    }
}


//Класс для грузового автомобиля
class TunkCar: Car {
    
    let model: models
    let yearProd: Int
    let trunkSizeInLiters: Int
    var presentIngineCond: ingineCondition
    var presentWindowCond: windowCondition
    var fullTrunkInLiters: Int
    
    //Колличество ведущих мостов у цистерны
    enum numAxelsTunkCar: String {
        case  two  = "два"
        case three = "три"
    }
    
    //Наличие у цистерны насоса для принудительного выкачивания
    enum pump: String {
        case present  = "есть"
        case nopresent = "отсутствует"
    }
    
    
    let numAxelsTC: numAxelsTunkCar
    let pumpTC: pump

    init(model: models, yearProd: Int,trunkSizeInLiters: Int, presentIngineCond: ingineCondition, presentWindowCond: windowCondition, fullTrunkInLiters: Int, numAxelsTC: numAxelsTunkCar, pumpTC: pump) {
        self.model = model
        self.yearProd=yearProd
        self.trunkSizeInLiters=trunkSizeInLiters
        self.presentIngineCond=presentIngineCond
        self.presentWindowCond=presentWindowCond
        self.fullTrunkInLiters=fullTrunkInLiters
        self.numAxelsTC = numAxelsTC
        self.pumpTC = pumpTC
        
    }
    
}

extension SportCar: CustomStringConvertible {
    var description: String {
        return "Марка автомобиля: \(model)\n"+"Год выпуска: \(yearProd)\n"+"Объем багажника в литрах: \(trunkSizeInLiters)\n"+"Состояние двигателя:  \(presentIngineCond.rawValue)\n"+"Состояние окон: \(presentWindowCond.rawValue)\n"+"Заполненость багажника в литрах: \(fullTrunkInLiters)\n"+"Количество дверей: \(numDoorSC.rawValue)\n"+"Корпус: \(materialBodySC.rawValue)\n"+"Размер тормозных дисков: \(braikDiscsSC.rawValue)\n"
       
    }
}

extension TunkCar: CustomStringConvertible {
    var description: String {
        return "Марка автомобиля: \(model)\n"+"Год выпуска: \(yearProd)\n"+"Объем цистерны в литрах: \(trunkSizeInLiters)\n"+"Состояние двигателя: \(presentIngineCond.rawValue)\n"+"Состояние окон:  \(presentWindowCond.rawValue)\n"+"Заполненость цистерны в литрах: \(fullTrunkInLiters)\n"+"Количество ведущий мостов: \(numAxelsTC.rawValue)\n"+"Наличие у цистерны насоса для принудительного выкачивания:  \(pumpTC.rawValue)\n"
       }
}


//Инициализация экземпляра спортивного автомобиля
var firstSportCar = SportCar(model: .BMW, yearProd: 2019, trunkSizeInLiters: 50, presentIngineCond: .notwork, presentWindowCond: .close, fullTrunkInLiters: 30, numDoorSC: .four, materialBodySC: .carbone, braikDiscsSC: .big)


print("Инициализирован экземпляр класса SportCar - спортивный автомобиль марки  \(firstSportCar.model), у которого выключен двигатель, закрыты окна, объем багажника составляет 50 литров и в багажнике размещен груз обьемом 30 литров, у автомобиля 4 двери, корпус сделан с углерода, тормозные диски большого размера\n")

print("Свойства экземпляра автомобиля марки BMW до применения действий:")
print(firstSportCar)

print("Сейчас будет выполнены методы (действия) по заведению двигателя:")
//Применение к экземпляру 1 действия
firstSportCar.actionsForAllCars(action: .startIngine)

print("\nСвойства экземпляра автомобиля марки \(firstSportCar.model) после применения действий:")
print(firstSportCar)


print("----------------//--------------------------//--------------------------//--------------------------//--------------------")


//Инициализация экземпляра грузового автомобиля
var firstTunkCar = TunkCar(model: .Toyota, yearProd: 2020, trunkSizeInLiters: 20000, presentIngineCond: .work, presentWindowCond: .open, fullTrunkInLiters: 10000, numAxelsTC: .three, pumpTC: .present)

print("Инициализирован экземпляр класса TunkCar -  цистерна марки \(firstTunkCar.model), у которой включен двигатель, открыты окна, объем цистерны составляет 20000 литров, в цистерне размещен груз обьемом 10000 литров, у автомобиля 3 ведущих моста, есть насос для принудительного выкачивания\n")

print("Свойства экземпляра грузового автомобиля марки \(firstTunkCar.model) до применения действий:")
print(firstTunkCar)

print("Сейчас будет выполнен метод (действия) по закрытию окон):")
//Применение к экземпляру 1 действия
firstTunkCar.actionsForAllCars(action: .closeWindow)


print("\nСвойства экземпляра грузового автомобиля марки \(firstTunkCar.model) после применения действий:")
print(firstTunkCar)

