import Foundation

struct PesticideDTO: Decodable {
    let image: String
    let category: PesticideCategoryDTO
    let name: String
    let description: String
    
    private enum CodingKeys: String, CodingKey {
        case image, name, description
        case category = "categories"
    }
}

struct PesticideCategoryDTO: Decodable {
    let id: Int
    let icon: String
    let image: String
    let name: String
}

extension PesticideDTO {
    var pesticideModel: Pesticide {
        Pesticide(
            image: "\(Constants.imageHost)\(image)",
            name: name,
            description: description,
            category: PesticideCategory(
                icon: "\(Constants.imageHost)\(category.icon)",
                image: "\(Constants.imageHost)\(category.image)"
            )
        )
    }
}
