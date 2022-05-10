//
//  AnnimationWithSwiftUIApp.swift
//  AnnimationWithSwiftUI
//
//  Created by mac-00017 on 09/05/22.
//

import SwiftUI

@main
struct AnnimationWithSwiftUIApp: App {
    
    var results = [
        UserModel(name: "Pish Patel",   color1: "Color-9", color2: "Color-10"),
        UserModel(name: "Anita Bath",   color1: "Color-1", color2: "Color-2"),
        UserModel(name: "Bea Mine",     color1: "Color-1", color2: "Color-2"),
        UserModel(name: "Dee End",      color1: "Color-3", color2: "Color-4"),
        UserModel(name: "Ben Dover",    color1: "Color-5", color2: "Color-6"),
        UserModel(name: "Dave Allippa", color1: "Color-1", color2: "Color-2"),
        UserModel(name: "Dee Zynah",    color1: "Color-1", color2: "Color-2"),
        UserModel(name: "Reeve Ewer",   color1: "Color-7", color2: "Color-8"),
        UserModel(name: "Tex Ryta",     color1: "Color-9", color2: "Color-10"),
        UserModel(name: "Faye Clether", color1: "Color-1", color2: "Color-2")
    ]
    
    var body: some Scene {
        WindowGroup {
            /* Card flip animation  */
//            CardFlipAnimation(arrModel: results)
            
            /* tinder card animation */
            let userProfiles: UserProfiles = Bundle.main.decode("userProfiles.json")
            TinderAnimation(userProfiles: userProfiles)
        }
    }
}

