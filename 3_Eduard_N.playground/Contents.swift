import UIKit
import Foundation

//Перечисление с моделями автомобилей
enum models {
    case Toyota, Mercedes, BMW, Fiat, Reno, Skoda, Subaru, Mazda, Volkswagen, Kia, Hyunday, Honda
}

//Перечисление с 2 состояниями двигателя - запущен/не запущен
enum ingineCondition {
    case work, notwork
}

//Перечисление с 2 состояниями окон - открыты/закрыты
enum windowCondition {
    case open, close
}

//Перечисление с возможными действиями - запустить/заглушить двигатель,открыть/закрыть окна, выгрузить/загрузить определенный груз
enum actions {
    case startIngine, stopIngine, openWindow, closeWindow
    case unload(cargoSizeInLiters: Int)
    case upload(cargoSizeInLiters: Int)
}

//Структура для легкового автомобиля (возможно было объединить со структурой грузового, но задача была "Описать несколько структур")
struct SportCar {
    let model: models
    let yearProd: Int
    let trackSizeInLiters: Int
    var presentIngineCond: ingineCondition
    var presentWindowCond: windowCondition
    var fullTrackInLiters: Int
    //Метод, который меняет свойства структуры в зависимости от действий
    mutating func actionsInStruct(action:actions) {
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
            if cargoSizeInLiters>(trackSizeInLiters-fullTrackInLiters) {
                print("Груз не выгружен. В багажнике автомобиля \(model) нет столько груза!")
            }
            else {
                fullTrackInLiters = trackSizeInLiters-cargoSizeInLiters
                print("Груз выгружен!")
            }
        case .upload(let cargoSizeInLiters):
            if cargoSizeInLiters>(trackSizeInLiters-fullTrackInLiters) {
                print("Груз не размещен. В багажнике автомобиля \(model) нет места для вашего груза!")
            }
            else {
                fullTrackInLiters += cargoSizeInLiters
                print("Груз размещен!")
            }
        }
    }
}

//Структура для грузового автомобиля (практически аналогична предыдущей структуре)
struct TrunkCar {
    let model: models
    let yearProd: Int
    let trackSizeInLiters: Int
    var presentIngineCond: ingineCondition
    var presentWindowCond: windowCondition
    var fullTrackInLiters: Int
    //Метод, который меняет свойства структуры в зависимости от действий
    mutating func actionsInStruct(action:actions) {
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
            if cargoSizeInLiters>(trackSizeInLiters-fullTrackInLiters) {
                print("Груз не выгружен. В кузове автомобиля \(model) нет столько груза!")
            }
            else {
                fullTrackInLiters -= cargoSizeInLiters
                print("Груз выгружен!")
            }
        case .upload(let cargoSizeInLiters):
            if cargoSizeInLiters>(trackSizeInLiters-fullTrackInLiters) {
                print("Груз не размещен. В кузове автомобиля \(model) нет места для вашего груза!")
            }
            else {
                fullTrackInLiters += cargoSizeInLiters
                print("Груз размещен!")
            }
        }
    }
}

//Функция вывода значений свойств экземпляра легкового автомобиля
func printSportCar(car: SportCar) {
    print(" Марка автомобиля: \(car.model)\n","Год выпуска: \(car.yearProd)\n","Объем багажника в литрах: \(car.trackSizeInLiters)\n", "Состояние двигателя (work - работает, notwork - не работает): \(car.presentIngineCond)\n", "Состояние окон (open - открыты, close - закрыты): \(car.presentWindowCond)\n","Заполненость багажника в литрах: \(car.fullTrackInLiters)\n")
}

//Функция вывода значений свойств экземпляра грузового автомобиля
func printTrunkCar(car: TrunkCar) {
    print(" Марка автомобиля: \(car.model)\n","Год выпуска: \(car.yearProd)\n","Объем кузова в литрах: \(car.trackSizeInLiters)\n", "Состояние двигателя (work - работает, notwork - не работает): \(car.presentIngineCond)\n", "Состояние окон (open - открыты, close - закрыты): \(car.presentWindowCond)\n","Заполненость кузова в литрах: \(car.fullTrackInLiters)\n")
}

//Инциализация экземпляра легкового автомобиля
var honda = SportCar(model: .Honda, yearProd: 2010, trackSizeInLiters: 50, presentIngineCond: .notwork, presentWindowCond: .close, fullTrackInLiters: 20)

print("Инициализирован экземпляр структуры SportCar - автомобиль марки  Honda, у которого выключен двигатель, объем багажника составляет 50 литров и в багажнике размещен груз обьемом 20 литров\n")

print("Свойства экземпляра автомобиля марки Honda до применения действий:")
printSportCar(car: honda)

print("Сейчас будет выполнен метод (действия) по включению двигателя и по размещению в багажник дополнительного груза объемом 60 литров:")
//Применение к экземпляру 2 действий
honda.actionsInStruct(action: .startIngine)
honda.actionsInStruct(action: .upload(cargoSizeInLiters:60))

print("\nСвойства экземпляра автомобиля марки Honda после применения действий:")
printSportCar(car: honda)


print("----------------//--------------------------//--------------------------//--------------------------//--------------------")
//Инциализация экземпляра грузового автомобиля
var bmw = TrunkCar(model: .BMW, yearProd: 2020, trackSizeInLiters: 20000, presentIngineCond: .work, presentWindowCond: .open, fullTrackInLiters: 10000)

print("Инициализирован экземпляр структуры TruckCar - грузовой автомобиль марки BMW, у которого включен двигатель, объем кузова составляет 20000 литров и в кузове размещен груз обьемом 10000 литров\n")

print("Свойства экземпляра грузового автомобиля марки BMW до применения действий:")
printTrunkCar(car: bmw)

print("Сейчас будет выполнен метод (действия) по закрытию окон и по извлечению из кузова груза объемом 5000 литров:")
//Применение к экземпляру 2 действий
bmw.actionsInStruct(action: .closeWindow)
bmw.actionsInStruct(action: .unload(cargoSizeInLiters:5000))

print("\nСвойства экземпляра грузового автомобиля марки BMW после применения действий:")
printTrunkCar(car: bmw)
