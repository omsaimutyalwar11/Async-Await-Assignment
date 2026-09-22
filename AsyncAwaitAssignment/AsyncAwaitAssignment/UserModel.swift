//
//  UserModel.swift
//  AsyncAwaitAssignment
//
//  Created by Omsai Mutyalwar on 22/09/26.
//

// Data model for the User for Task 2 and Task 3
struct User: Decodable, Equatable {

    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String

    // Fields of Address.
    let street: String
    let suite: String
    let city: String
    let zipcode: String

    // Fields of Geo.
    let latitude: String
    let longitude: String

    // Fields of Company.
    let companyName: String
    let catchPhrase: String
    let companyDescription: String

    // Keys at the top level.
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case email
        case address
        case phone
        case website
        case company
    }

    // Keys inside the "address" object.
    enum AddressKeys: String, CodingKey {
        case street
        case suite
        case city
        case zipcode
        case geo
    }

    // Keys inside the "geo" object.
    enum GeoKeys: String, CodingKey {
        case lat
        case lng
    }

    // Keys inside the "company" object.
    enum CompanyKeys: String, CodingKey {
        case name
        case catchPhrase
        case bs
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        username = try container.decode(String.self, forKey: .username)
        email = try container.decode(String.self, forKey: .email)
        phone = try container.decode(String.self, forKey: .phone)
        website = try container.decode(String.self, forKey: .website)

        let addressContainer = try container.nestedContainer(keyedBy: AddressKeys.self, forKey: .address)
        street = try addressContainer.decode(String.self, forKey: .street)
        suite = try addressContainer.decode(String.self, forKey: .suite)
        city = try addressContainer.decode(String.self, forKey: .city)
        zipcode = try addressContainer.decode(String.self, forKey: .zipcode)

        let geoContainer = try addressContainer.nestedContainer(keyedBy: GeoKeys.self, forKey: .geo)
        latitude = try geoContainer.decode(String.self, forKey: .lat)
        longitude = try geoContainer.decode(String.self, forKey: .lng)

        let companyContainer = try container.nestedContainer(keyedBy: CompanyKeys.self, forKey: .company)
        companyName = try companyContainer.decode(String.self, forKey: .name)
        catchPhrase = try companyContainer.decode(String.self, forKey: .catchPhrase)
        companyDescription = try companyContainer.decode(String.self, forKey: .bs)
    }

    init(
        id: Int,
        name: String,
        username: String,
        email: String,
        street: String,
        suite: String,
        city: String,
        zipcode: String,
        latitude: String,
        longitude: String,
        phone: String,
        website: String,
        companyName: String,
        catchPhrase: String,
        companyDescription: String
    ) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.latitude = latitude
        self.longitude = longitude
        self.phone = phone
        self.website = website
        self.companyName = companyName
        self.catchPhrase = catchPhrase
        self.companyDescription = companyDescription
    }
}
