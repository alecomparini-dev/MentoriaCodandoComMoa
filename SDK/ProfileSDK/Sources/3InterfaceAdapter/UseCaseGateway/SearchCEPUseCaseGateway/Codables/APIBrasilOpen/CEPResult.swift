//
//  File.swift
//  
//
//  Created by Alessandro Comparini on 14/10/23.
//

import Foundation

public struct CEPResult: Codable {
    public var street: String?
    public var complement: String?
    public var district: String?
    public var districtID: Int?
    public var city: String?
    public var cityID: Int?
    public var ibgeID: Int?
    public var state: String?
    public var stateShortname: String?
    public var zipcode: String?

    enum CodingKeys: String, CodingKey {
        case street, complement, district
        case districtID = "districtId"
        case city
        case cityID = "cityId"
        case ibgeID = "ibgeId"
        case state, stateShortname, zipcode
    }

    public init(street: String?, complement: String?, district: String?, districtID: Int?, 
                city: String?, cityID: Int?, ibgeID: Int?, state: String?, stateShortname: String?,
                zipcode: String?) {
        self.street = street
        self.complement = complement
        self.district = district
        self.districtID = districtID
        self.city = city
        self.cityID = cityID
        self.ibgeID = ibgeID
        self.state = state
        self.stateShortname = stateShortname
        self.zipcode = zipcode
    }
}
