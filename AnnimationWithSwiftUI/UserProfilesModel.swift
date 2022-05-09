//
//  Model.swift
//  AnnimationWithSwiftUI
//
//  Created by Mac-0004 on 05/05/22.
//

import Foundation


struct UserProfiles : Codable {
    let results : [Results]?

    enum CodingKeys: String, CodingKey {

        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decodeIfPresent([Results].self, forKey: .results)
    }
}

struct Results : Codable, Identifiable {
    var id = UUID()
    let distance_mi : Int?
    let common_like_count : Int?
    let common_friend_count : Int?
    let common_likes : [String]?
    let common_friends : [String]?
    let profileid : String?
    let bio : String?
    let birth_date : String?
    let gender : String?
    let name : String?
    let ping_time : String?
    let photos : [Photos]?
    let birth_date_info : String?

    enum CodingKeys: String, CodingKey {

        case distance_mi = "distance_mi"
        case common_like_count = "common_like_count"
        case common_friend_count = "common_friend_count"
        case common_likes = "common_likes"
        case common_friends = "common_friends"
        case profileid = "profileid"
        case bio = "bio"
        case birth_date = "birth_date"
        case gender = "gender"
        case name = "name"
        case ping_time = "ping_time"
        case photos = "photos"
        case birth_date_info = "birth_date_info"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        distance_mi = try values.decodeIfPresent(Int.self, forKey: .distance_mi)
        common_like_count = try values.decodeIfPresent(Int.self, forKey: .common_like_count)
        common_friend_count = try values.decodeIfPresent(Int.self, forKey: .common_friend_count)
        common_likes = try values.decodeIfPresent([String].self, forKey: .common_likes)
        common_friends = try values.decodeIfPresent([String].self, forKey: .common_friends)
        profileid = try values.decodeIfPresent(String.self, forKey: .profileid)
        bio = try values.decodeIfPresent(String.self, forKey: .bio)
        birth_date = try values.decodeIfPresent(String.self, forKey: .birth_date)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        ping_time = try values.decodeIfPresent(String.self, forKey: .ping_time)
        photos = try values.decodeIfPresent([Photos].self, forKey: .photos)
        birth_date_info = try values.decodeIfPresent(String.self, forKey: .birth_date_info)
    }
}

struct Photos : Codable, Identifiable {
    var id = UUID()
    let main : Bool?
    let url : String?

    enum CodingKeys: String, CodingKey {
        case main = "main"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        main = try values.decodeIfPresent(Bool.self, forKey: .main)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}


