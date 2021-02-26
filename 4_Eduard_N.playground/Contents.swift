import UIKit
import Foundation

//Перечисление с видами автомобилей
enum typeCar {
    case Sportcar
    case TruckCar
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
    
    //только для спортивных автомобилей - поднять/опустить спойлер, увеличить/уменьшить клиренс, включить/выключить режим Sport коробки передач
    case upspoiler, downspoiler, incClearance, decClearance, onSport, offSport

    //только для грузовых автомобилей - включить/выключить дополнительные ведущие мосты, поднять/опустить кабину
    case  onAxels, offAxels, upCabin, downCabin
}


//Класс общий для всех автомобилей
class Car {
    let model: models
    let yearProd: Int
    let trackSizeInLiters: Int
    var presentIngineCond: ingineCondition
    var presentWindowCond: windowCondition
    var fullTrackInLiters: Int
    
    init (model: models, yearProd: Int,trackSizeInLiters: Int, presentIngineCond: ingineCondition, presentWindowCond: windowCondition, fullTrackInLiters: Int){
        self.model = model
        self.yearProd = yearProd
        self.trackSizeInLiters = trackSizeInLiters
        self.presentIngineCond = presentIngineCond
        self.presentWindowCond = presentWindowCond
        self.fullTrackInLiters = fullTrackInLiters
    }
    //Пока пустой общий метод
    func actionsInStruct(action: actionsAllCar, type: typeCar) {
    }
}

//Структура для спортивного автомобиля
class SportCar: Car {
    
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
    
    //Варианты состояния спойлера - поднят(т.е. активен) или опущен (спрятан/пасивен)
    enum pozSpoiler: String {
        case spoilerTop  = "спойлер поднят"
        case spoilerBelow = "спойлер опущен"
    }
 
    //Варианты клиренса - увеличеный (для обычной езды) и уменьшеный (для скоростного режима)
    enum sizeClearance: String {
        case highClearance  = "клиренс увеличен"
        case lowClearance = "клиренс уменьшен"
    }
    
    //Режим коробки передач - спортивный или обычный
    enum sportMode: String  {
        case on  = "спорт"
        case off = "обычный"
    }
    
    let numDoorSC: numDoorSportCar
    let materialBodySC: materialBodySportCar
    let braikDiscsSC: braikDiscsSportCar
    var presentPozSpoiler: pozSpoiler
    var presentSizeClerance: sizeClearance
    var presentSportMode: sportMode
    
    init(model: models, yearProd: Int,trackSizeInLiters: Int, presentIngineCond: ingineCondition, presentWindowCond: windowCondition, fullTrackInLiters: Int, numDoorSC: numDoorSportCar, materialBodySC: materialBodySportCar, braikDiscsSC: braikDiscsSportCar, presentPozSpoiler: pozSpoiler, presentSizeClerance: sizeClearance, presentSportMode: sportMode) {
        self.numDoorSC = numDoorSC
        self.materialBodySC = materialBodySC
        self.braikDiscsSC = braikDiscsSC
        self.presentPozSpoiler = presentPozSpoiler
        self.presentSizeClerance = presentSizeClerance
        self.presentSportMode = presentSportMode
        super.init(model: model, yearProd: yearProd, trackSizeInLiters: trackSizeInLiters, presentIngineCond: presentIngineCond, presentWindowCond: presentWindowCond, fullTrackInLiters: fullTrackInLiters)
    }
    //Создание метода изменяющего состояние спойлера, величины клиренса и режима коробки передач
    override func actionsInStruct(action: actionsAllCar, type: typeCar) {
        //Вызов общего метода на случай если он не пустой
        super.actionsInStruct(action: action, type: type)
        
        switch action {
        case .upspoiler:
            presentPozSpoiler = .spoilerTop
            print("Спойлер \(type) поднят!")
        case .downspoiler:
            presentPozSpoiler = .spoilerBelow
            print("Спойлер \(type) опущен!")
        case .incClearance:
            presentSizeClerance = .highClearance
            print("Клиренс \(type) увеличен!")
        case .decClearance:
            presentSizeClerance = .lowClearance
            print("Клиренс \(type) увеличен!")
        case .onSport:
            presentSportMode = .on
            print("Коробка передач \(type) переведена в спортивный режим!")
        case .offSport:
            presentSportMode = .off
            print("Коробка передач \(type) переведена в обычный режим!")
        default: break
        }
    }
}


//Структура для грузового автомобиля
class TrunkCar: Car {
    
    //Колличество ведущих мостов у грузового автомобиля
    enum numAxelsTrunkCar: String {
        case  two  = "два"
        case three = "три"
    }
    
    //Вид кузова грузового автомобиля - бортовой или тентованый
    enum bodyTrunkCar: String {
        case flatbed  = "бортовой"
        case tarpaulin = "тентованый"
    }
    
    //Варианты работы ведущих мостов - все включены или только один (основной)
    enum addAxels: String  {
        case on = "включены все мосты"
        case off = "включен только основной мост"
    }
 
    //Положение кабины водителя - поднята(машина на ремонте/осмотре) или опущена
    enum pozCabin: String  {
        case up = "кабина поднята"
        case down = "кабина опущена"
    }
    
    
    let numAxelsTC: numAxelsTrunkCar
    let bodyTC: bodyTrunkCar
    var presentAddAxels: addAxels
    var presentPozCabin: pozCabin
    init(model: models, yearProd: Int,trackSizeInLiters: Int, presentIngineCond: ingineCondition, presentWindowCond: windowCondition, fullTrackInLiters: Int, numAxelsTC: numAxelsTrunkCar, bodyTC: bodyTrunkCar, presentAddAxels: addAxels, presentPozCabin: pozCabin) {
        self.numAxelsTC = numAxelsTC
        self.bodyTC = bodyTC
        self.presentAddAxels = presentAddAxels
        self.presentPozCabin = presentPozCabin
        super.init(model: model, yearProd: yearProd, trackSizeInLiters: trackSizeInLiters, presentIngineCond: presentIngineCond, presentWindowCond: presentWindowCond, fullTrackInLiters: fullTrackInLiters)
    }
    
    //Создание метода изменяющего (фиксирующего) режим работы мостов и состояние кабины водителя
    override func actionsInStruct(action: actionsAllCar, type: typeCar) {
        super.actionsInStruct(action: action, type: type)
        
        //case  onAxels, offAxels, upCabin, downCabin
        
        switch action {
        case .onAxels:
            presentAddAxels = .on
            print("У \(type) включены все ведущие мосты!")
        case .offAxels:
            presentAddAxels = .off
            print("У \(type) включен только основной ведущий мост!")
        case .upCabin:
            presentPozCabin = .up
            print("Водительская кабина \(type) поднята!")
        case .downCabin:
            presentPozCabin = .down
            print("Водительская кабина \(type) опущена!")
        default: break
        }
    }
}



//Функция вывода значений свойств экземпляра спортивного автомобиля
func printSportCar(car: SportCar) {
    print(" Марка автомобиля: \(car.model)\n","Год выпуска: \(car.yearProd)\n","Объем багажника в литрах: \(car.trackSizeInLiters)\n", "Состояние двигателя:  \(car.presentIngineCond.rawValue)\n", "Состояние окон: \(car.presentWindowCond.rawValue)\n","Заполненость багажника в литрах: \(car.fullTrackInLiters)\n","Количество дверей: \(car.numDoorSC.rawValue)\n","Корпус: \(car.materialBodySC.rawValue)\n", "Размер тормозных дисков: \(car.braikDiscsSC.rawValue)\n","Положение(состояние) спойлера: \(car.presentPozSpoiler.rawValue)\n", "Размер клиренса: \(car.presentSizeClerance.rawValue)\n", "Режим коробки передач:  \(car.presentSportMode.rawValue)\n")

}

//Функция вывода значений свойств экземпляра грузового автомобиля
func printTrunkCar(car: TrunkCar) {
    print(" Марка автомобиля: \(car.model)\n","Год выпуска: \(car.yearProd)\n","Объем кузова в литрах: \(car.trackSizeInLiters)\n", "Состояние двигателя: \(car.presentIngineCond.rawValue)\n", "Состояние окон:  \(car.presentWindowCond.rawValue)\n","Заполненость кузова в литрах: \(car.fullTrackInLiters)\n","Количество ведущий мостов: \(car.numAxelsTC.rawValue)\n", "Вид кузова грузового автомобиля:  \(car.bodyTC.rawValue)\n","Состояние ведущих мостов: \(car.presentAddAxels.rawValue)\n", "Положение водительской кабины:  \(car.presentPozCabin.rawValue)\n")
}

print("Чтобы не делать код программы излишне громоздким создано было по одному объекту каждого класса!\n")

//Инциализация экземпляра спортивного автомобиля

var firstSportCar = SportCar(model: .BMW, yearProd: 2019, trackSizeInLiters: 50, presentIngineCond: .notwork, presentWindowCond: .close, fullTrackInLiters: 30, numDoorSC: .four, materialBodySC: .carbone, braikDiscsSC: .big, presentPozSpoiler: .spoilerBelow, presentSizeClerance: .highClearance, presentSportMode: .off)


print("Инициализирован экземпляр класса SportCar - спортивный автомобиль марки  \(firstSportCar.model) , у которого выключен двигатель, объем багажника составляет 50 литров и в багажнике размещен груз обьемом 30 литров, у автомобиля 4 двери, корпус сделан с углерода, тормозные диски больше стандартного размера, спойлер опущен, клиренс увеличен и спортивный режим коробки передач отключен\n")

print("Свойства экземпляра автомобиля марки BMW до применения действий:")
printSportCar(car: firstSportCar)

print("Сейчас будет выполнены методы (действия) по поднятию спойлера, уменьшению клиренса и переходу коробки передач в спортивный режим:")
//Применение к экземпляру 3 действий
firstSportCar.actionsInStruct(action: .upspoiler, type: .Sportcar)
firstSportCar.actionsInStruct(action: .decClearance, type: .Sportcar)
firstSportCar.actionsInStruct(action: .onSport, type: .Sportcar)

print("\nСвойства экземпляра автомобиля марки \(firstSportCar.model) после применения действий:")
printSportCar(car: firstSportCar)


print("----------------//--------------------------//--------------------------//--------------------------//--------------------")


//Инциализация экземпляра грузового автомобиля
var firstTrunkCar = TrunkCar(model: .Toyota, yearProd: 2020, trackSizeInLiters: 20000, presentIngineCond: .work, presentWindowCond: .open, fullTrackInLiters: 10000, numAxelsTC: .three, bodyTC: .tarpaulin, presentAddAxels: .off, presentPozCabin: .down)

print("Инициализирован экземпляр структуры TruckCar - грузовой автомобиль марки \(firstTrunkCar.model), у которого включен двигатель, объем кузова составляет 20000 литров, в кузове размещен груз обьемом 10000 литров, у автомобиля 3 ведущих моста, автомобиль тентованный, работает только основной ведущий мост, кабина водителя опущена (не на ремонте)\n")

print("Свойства экземпляра грузового автомобиля марки \(firstTrunkCar.model) до применения действий:")
printTrunkCar(car: firstTrunkCar)

print("Сейчас будет выполнен метод (действия) по включению всех мостов и подьему кабины для проведения ремонта(осмотра):")
//Применение к экземпляру 2 действий
firstTrunkCar.actionsInStruct(action: .onAxels, type: .TruckCar)
firstTrunkCar.actionsInStruct(action: .upCabin, type: .TruckCar)

print("\nСвойства экземпляра грузового автомобиля марки \(firstTrunkCar.model) после применения действий:")
printTrunkCar(car: firstTrunkCar)

