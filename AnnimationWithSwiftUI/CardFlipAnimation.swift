//
//  CardFlipAnimation.swift
//  AnnimationWithSwiftUI
//
//  Created by mac-00017 on 09/05/22.
//

import SwiftUI
import AVFoundation

// User Model
struct UserModel : Hashable {
    let id = UUID()
    let name: String
    let color1: String
    let color2: String
}

struct CardFlipAnimation: View {
    
    var arrModel: [UserModel]
    
    // GridItem
    var gridItemLayout = [GridItem(.flexible(minimum: (CScreenWidth * 180) / 390, maximum: (CScreenWidth * 180) / 390)),GridItem(.flexible(minimum: (CScreenWidth * 180) / 390, maximum: (CScreenWidth * 180) / 390))]
    
    var body: some View {
        
        ZStack {
            // ScrollView vertical
            ScrollView(.vertical) {
                // LazyVGrid Grid Item Layout
                LazyVGrid(columns: gridItemLayout) {
                    ForEach(arrModel, id: \.self) { dict in
                        CardView1(name: dict.name,color1: dict.color1,color2: dict.color2)
                    }
                }
            }
        }
    }
}

struct CardView1: View {
    
    @State var flipped: Bool = false
    @State var flashcardRotation = 0.0
    @State var contentRotation = 0.0
    let name: String
    let color1: String
    let color2: String
    
    var body: some View {
        
        ZStack {
            if flipped {
                FrontView(color1: color1, color2: color2)
            } else {
                BackView(name: name,color1: color1, color2: color2)
            }
            Button(action: {
                AudioServicesPlaySystemSound(1109) // sound
                UINotificationFeedbackGenerator().notificationOccurred(.success) // short vibrations
                flipFlashcard()
            }) {
                SideButton(imageName: flipped ? "chevron.left.2" : "chevron.right.2")
            }.offset(x: (CScreenWidth * 70) / 390, y: (CScreenWidth * -70) / 390)
        }
        // roted content and card
        .rotation3DEffect(.degrees(contentRotation), axis: (x: 0, y: 1, z: 0))
        .rotation3DEffect(.degrees(flashcardRotation), axis: (x: 0, y: 1, z: 0))
        
    }
    // Animation
    func flipFlashcard() {
        withAnimation(Animation.linear(duration: 0.5)) {
            flipped ? (flashcardRotation -= 180) : (flashcardRotation += 180)
        }
        
        withAnimation(Animation.linear(duration: 0.001).delay(0.5 / 2)) {
            contentRotation += 180
            flipped.toggle()
        }
    }
}

struct FrontView: View {
    
    var color1 : String = ""
    var color2 : String = ""
    
    var body: some View{
        
        ZStack() {
            // Card
            Rectangle()
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [Color(color1), Color(color2)]),startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .clipShape(CustomShape(
                    corner: [.bottomRight,.topLeft,.bottomLeft,.topRight], radii: (CScreenWidth * 18) / 390
                ))
                .frame(width: (CScreenWidth * 180) / 390, height: (CScreenWidth * 180) / 390, alignment: .center)
           // Skills Text
            VStack {
                HStack{
                    Text("Skills")
                        .font(.custom("Poppins-SemiBold", size: (CScreenWidth * 20) / 390))
                        .foregroundColor(Color.white)
                }
                Spacer().frame(width: 0, height: (CScreenWidth * 10) / 390, alignment: .center)
                
                HStack {
                    SkillTitle(title:"Unity3D")
                    SkillTitle(title:"Android")
                    SkillTitle(title:"iOS")
                }.padding()
                // Social images
                HStack {
                    SocialImage(imageName: "fb")
                    SocialImage(imageName: "instagram")
                    SocialImage(imageName: "link")
                }
            }
        }
    }
}

struct BackView: View {
    
    var name : String = ""
    var color1 : String = ""
    var color2 : String = ""
    
    var body: some View {
        ZStack {
            // Card
            Rectangle()
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [Color(color1), Color(color2)]),startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .clipShape(CustomShape(
                    corner: [.bottomRight,.topLeft,.bottomLeft,.topRight], radii: (CScreenWidth * 18) / 390
                ))
                .frame(width: (CScreenWidth * 180) / 390, height: (CScreenWidth * 180) / 390, alignment: .center)
            
            // User Details
            VStack(spacing:8){
                Image("mainwizard")
                    .resizable()
                    .frame(width: (CScreenWidth * 80) / 390, height: (CScreenWidth * 80) / 390, alignment: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: (CScreenWidth * 2) / 390))
                
                Text(name)
                    .font(.custom("Poppins-SemiBold", size: (CScreenWidth * 18) / 390))
                    .foregroundColor(Color.white)
            
                Text("Mobile Developer")
                    .font(.custom("Poppins-Regular", size: (CScreenWidth * 14) / 390))
                    .foregroundColor(Color.white)
            }
        }
    }
}

struct SideButton: View {
    
    var imageName : String = ""
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: (CScreenWidth * 35) / 390, height: (CScreenWidth * 35) / 390, alignment: .center)
                .foregroundColor(.clear)
                .shadow(radius: (CScreenWidth * 7) / 390)
            
            ZStack{
                Image(systemName:imageName)
                    .resizable()
                    .foregroundColor(Color.white)
                    .frame(width: (CScreenWidth * 17) / 390, height: (CScreenWidth * 17) / 390, alignment: .center)
            }
        }
    }
}

struct SocialImage: View
{
    let imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: (CScreenWidth * 30) / 390, height: (CScreenWidth * 30) / 390, alignment: .center)
    }
}
struct SkillTitle: View
{
    let title: String

    var body: some View {
        ZStack {
            Text(title)
                .foregroundColor(.white)
                .font(.custom("Poppins-Regular", size: (CScreenWidth * 14) / 390))
                .underline()
        }
    }
}
struct CustomShape: Shape {
    var corner : UIRectCorner
    var radii : CGFloat
    
    func path(in rect : CGRect) -> Path{
        return Path(UIBezierPath(roundedRect : rect, byRoundingCorners: corner, cornerRadii: CGSize(width: radii, height: radii)).cgPath)
    }
}


let CMainScreen = UIScreen.main
let CBounds = CMainScreen.bounds

let CScreenSize = CBounds.size
let CScreenWidth = CScreenSize.width
let CScreenHeight = CScreenSize.height

