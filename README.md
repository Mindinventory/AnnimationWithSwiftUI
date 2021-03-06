# SwiftUI - Annimation
<a href="https://developer.apple.com/ios/" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-iOS-red">
</a>
<a href="https://www.codacy.com?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=nikunjprajapati95/Reading-Animation&amp;utm_campaign=Badge_Grade"><img src="https://app.codacy.com/project/badge/Grade/44b16d6ddb96446b875d38bf2ec89b11"/></a>
<a href="https://github.com/nikunjprajapati95/Reading-Animation/blob/main/LICENSE" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/licence-MIT-orange">
</a>
<p></p> 

Animations are a way of fascinate the users of your application. Thorugh the annimations user can come accorss the smooth and friendly experience of the application 

Have you thought of doing animation using UIKit then probably it will demand for the complex logic and code set up but SwiftUI make it trouble - free. SwiftUI handled all the complexity and create a animation view.

#### Let’s see some of the serviceable and applicable animation solution which can be used during application development



### FlipAnimation : [CardFlipAnimation](https://github.com/Mindinventory/AnnimationWithSwiftUI/blob/main/AnnimationWithSwiftUI/CardFlipAnimation.swift)

<p align="center">
  <img src="https://user-images.githubusercontent.com/42262083/167624918-ed5356b0-5982-434b-b1d1-5e153df42bc1.gif">
</p>

Drag and drop the CardFlipAnimation file and use it like below
```swift
var results = [UserModel(name: "Pish Patel",   color1: "Color-9", color2: "Color-10"),
               UserModel(name: "Anita Bath",   color1: "Color-1", color2: "Color-2"),
               UserModel(name: "Bea Mine",     color1: "Color-1", color2: "Color-2")]

CardFlipAnimation(arrModel: results)
```

```swift
withAnimation(Animation.linear(duration: 0.5)) {
}
```
## Requirements
- iOS 13.0+
- Xcode 12.5+

### TinderSwipe : [TinderAnimation](https://github.com/Mindinventory/AnnimationWithSwiftUI/blob/main/AnnimationWithSwiftUI/TinderAnimation.swift)

<p align="center">
  <img src="https://user-images.githubusercontent.com/42262083/167624925-7f233636-cc97-4a56-a258-e8586dba7c6b.gif">
</p>

Use the file TinderAnimation and use it like

```swift
let userProfiles: UserProfiles = Bundle.main.decode("userProfiles.json")
TinderAnimation(userProfiles: userProfiles)
```

```swift
.gesture(gesture: Gesture)
.scaleEffect(CGFloat)
.rotationEffect(angle: Angle)
.animation(animation: Animation)
```

## Requirements
- iOS 15.0+
- Xcode 13.0+

## 📱 Check out other lists of our Mobile UI libraries

<a href="https://github.com/Mindinventory?language=kotlin"> 
<img src="https://img.shields.io/badge/Kotlin-0095D5?&style=for-the-badge&logo=kotlin&logoColor=white"> </a>

<a href="https://github.com/Mindinventory?language=swift"> 
<img src="https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white"> </a>

<a href="https://github.com/Mindinventory?language=dart"> 
<img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white"> </a>


<a href="https://github.com/Mindinventory/react-native-tabbar-interaction"> 
<img src="https://img.shields.io/badge/React_Native-20232A?style=for-the-badge&logo=react&logoColor=61DAFB"> </a>

<br></br>

## 💻 Check out other lists of Web libraries

<a href="hhttps://github.com/Mindinventory?language=javascript"> 
<img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black"></a>

<a href="https://github.com/Mindinventory?language=go"> 
<img src="https://img.shields.io/badge/Go-00ADD8?style=for-the-badge&logo=go&logoColor=white"></a>

<a href="https://github.com/Mindinventory?language=python"> 
<img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white"></a>

<br></br>

<h4><a href="https://www.mindinventory.com/whitepapers.php?utm_source=gthb&utm_medium=special&utm_campaign=folding-cell#demo"><u> 📝 Get FREE Industry WhitePapers →</u></a></h4>

## Check out our Work
<a href="https://dribbble.com/mindinventory"> 
<img src="https://img.shields.io/badge/Dribbble-EA4C89?style=for-the-badge&logo=dribbble&logoColor=white" /> </a>
<br></br>

## 📄 License
CardFlipSwiftUI is [MIT-licensed](/LICENSE).


If you use our open-source libraries in your project, please make sure to credit us and Give a star to www.mindinventory.com

<a href="https://www.mindinventory.com/contact-us.php?utm_source=gthb&utm_medium=repo&utm_campaign=swift-ui-libraries">
<img src="https://github.com/Sammindinventory/MindInventory/blob/main/hirebutton.png" width="203" height="43"  alt="app development">
</a>
