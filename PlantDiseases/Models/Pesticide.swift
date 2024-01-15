import Foundation

struct Pesticide: Identifiable {
    let id = UUID().uuidString
    let image: String
    let name: String
    let description: String
    let category: PesticideCategory
    
    static var example: Self {
        Pesticide(
            image: "http://shans.d2.i-partner.ru/upload/drugs/Гоплит, КС M_74a47412.png",
            name: "ГОПЛИТ, КС*",
            description: "Системный инсектицид широкого спектра активности с продолжительным периодом действия\r\n*препарат в процессе регистрации",
            category: .exemple
        )
    }
}
