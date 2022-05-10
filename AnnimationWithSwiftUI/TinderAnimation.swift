//
//  TinderAnimation.swift
//  AnnimationWithSwiftUI
//
//  Created by mac-00017 on 09/05/22.
//

import SwiftUI

struct TinderAnimation: View {
    //MARK: - properties -
    let userProfiles: UserProfiles
    @State var cardViews = [CardView]()
    @GestureState var dragState = DragState.inactive
    var dragAreaThreshold: CGFloat = 65.0
    @State var lastCardIndex = 1
    @State var cardRemovaltransition = AnyTransition.trailingBottom
    
    //MARK: - Drag States
    
    enum DragState {
        case inactive
        case pressing
        case dragging(translation: CGSize)
        
        
        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        var isDragging:Bool {
            switch self {
            case .dragging:
                return true
            case .inactive, .pressing:
                return false
            }
        }
        
        var isPressing: Bool {
            switch self {
            case .pressing, .dragging :
                return true
            case .inactive:
                return false
            }
        }
    }
    
    
    //MARK: - Body -
    var body: some View {
        VStack{
            //MARK: Header
            HeaderView()
                .opacity(dragState.isDragging ? 0.0 : 1.0)
                .animation(.default, value: dragState.isDragging)
            
            //MARK: CardView
            ZStack{
                if let cardViews = cardViews {
                    ForEach(cardViews) { card in
                        card
                            .zIndex(self.isTopCard(cardView: card) ? 1 : 0)
                            .overlay(content: {
                                ZStack{
                                    // X-MARK SYMBOL
                                    Image(systemName: "x.circle")
                                        .modifier(SymbolModifier())
                                        .opacity(self.dragState.translation.width < -self.dragAreaThreshold && self.isTopCard(cardView: card) ? 1.0 : 0.0)
                                    
                                    // HEART SYMBOL
                                    Image(systemName: "heart.circle")
                                        .modifier(SymbolModifier())
                                        .opacity(self.dragState.translation.width > self.dragAreaThreshold && self.isTopCard(cardView: card) ? 1.0 : 0.0)
                                }
                            })
                            .offset(x: self.isTopCard(cardView: card) ?  self.dragState.translation.width : 0, y: self.isTopCard(cardView: card) ? self.dragState.translation.height : 0)
                            .scaleEffect(self.dragState.isDragging && self.isTopCard(cardView: card) ? 0.85 : 1)
                            .rotationEffect(Angle(degrees:self.isTopCard(cardView: card) ?  Double(self.dragState.translation.width / 12) : 0))
                            .animation(.interpolatingSpring(stiffness: 120, damping: 120), value: self.dragState.translation)
                            .gesture(LongPressGesture(minimumDuration: 0.01)
                                        .sequenced(before: DragGesture())
                                        .updating(self.$dragState, body: { value, state, transaction in
                                switch value {
                                case .first(true):
                                    state = .pressing
                                case .second(true, let drag):
                                    state = .dragging(translation: drag?.translation ?? .zero)
                                default:
                                    break
                                }
                            })
                                        .onChanged({ value in
                                guard case .second(true, let drag?) = value else {return}
                                if drag.translation.width < -self.dragAreaThreshold {
                                    self.cardRemovaltransition = .leadingBottom
                                }
                                
                                if drag.translation.width > self.dragAreaThreshold {
                                    self.cardRemovaltransition = .trailingBottom
                                }
                                
                            })
                                        .onEnded({ value in
                                guard case .second(true, let drag?) = value else {
                                    return
                                }
                                if drag.translation.width < -self.dragAreaThreshold || drag.translation.width > self.dragAreaThreshold {
                                    self.moveCards()
                                }
                            })
                            ).transition(cardRemovaltransition)
                        
                    }
                }
            }
            
            Spacer()
            
            //MARK: Footer
            FooterView()
        }
        .padding(.bottom, 20)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            self.cardViews = loadCardViewData()
        }
    }
    
    private func moveCards() {
        cardViews.removeFirst()
        
        self.lastCardIndex += 1
        if let profileCard = userProfiles.results?[lastCardIndex % (userProfiles.results?.count ?? 0)] {
            let newCarView = CardView(user: profileCard)
            cardViews.append(newCarView)
        }
    }
    
    private func loadCardViewData() -> [CardView] {
        var views = [CardView]()
        if let userprofiles = userProfiles.results {
            for index in 0..<2 {
                views.append(CardView(user: userprofiles[index]))
            }
        }
        return views
    }
    
    private func isTopCard(cardView: CardView) -> Bool {
        guard let index = cardViews.firstIndex(where: {$0.id == cardView.id}) else {return false}
        return index == 0
    }
}

struct CardView: View, Identifiable {
    var id = UUID()
    var user: Results
    var style: UIBlurEffect.Style = .systemUltraThinMaterial
    var body: some View {
        ZStack{
            ForEach(user.photos ?? []) { userProfile in
                if userProfile.main == true {
                    Image(userProfile.url ?? "")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .overlay(alignment: .bottom, content: {
                            ZStack{
                                VisualEffectView(style: style)
                                    .cornerRadius(25)
                                    .opacity(50)
                                VStack(alignment: .center){
                                    HStack {
                                        VStack(alignment: .leading){
                                            Text(user.name ?? "Agne")
                                                .font(.title)
                                                .fontWeight(.semibold)
                                            Text(user.gender ?? "female")

                                        }
                                        Spacer()
                                    }
                                    .padding(.leading, 20)
                                }
                            }
                            .frame(minHeight: 0 ,maxHeight: 100)
                        })
                }
            }
        }
        .cornerRadius(20)
        .padding()
    }
}
struct HeaderView: View {
    var body: some View {
        HStack {
            Button {
                print("Information")
            } label: {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .renderingMode(.original)
                    .scaledToFit()
                    .font(.system(size: 24, weight: .regular))
                    .frame(width: 40, height: 40, alignment: .center)
                    .padding()
            }
            .buttonStyle(StaticButtonStyle())
            .tint(.primary)
            Spacer()
        }
        .padding(.trailing, 110)
    }
}

struct FooterView: View {
    
    //MARK: - Body
    var body: some View {
        HStack{
            Button {
                print("Dislike Button")
            } label: {
                Image(systemName: "xmark.circle")
                    .renderingMode(.template)
                    .font(.system(size: 42, weight: .light))
                    .padding()
            } //: Button
            .buttonStyle(StaticButtonStyle())
            .foregroundColor(.black)
            Spacer()
            Text("Swipe") //: Text
                .foregroundColor(.pink)
                .font(.system(size: 25, weight: .bold, design: .serif))
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(
                    Capsule().stroke(.pink, lineWidth: 2)
                )
            Spacer()
            Button {
                print("Like Button")
            } label: {
                Image(systemName: "heart.circle")
                    .renderingMode(.template)
                    .foregroundColor(.black)
                    .font(.system(size: 42, weight: .light))
                    .padding()
            } //: Button
            .buttonStyle(StaticButtonStyle())
        } //: HStack
    }
}

struct VisualEffectView: UIViewRepresentable {
    typealias UIViewType = UIVisualEffectView
    var style: UIBlurEffect.Style = .systemUltraThinMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}
struct SymbolModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.white)
            .font(.system(size: 128))
            .shadow(color: Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)), radius: 12, x: 0, y: 0)
    }
}
extension AnyTransition {
    static var trailingBottom: AnyTransition {
        AnyTransition.asymmetric(insertion: .identity, removal: AnyTransition.move(edge: .trailing).combined(with: .move(edge: .bottom)))
    }
    
    static var leadingBottom: AnyTransition {
        AnyTransition.asymmetric(insertion: .identity, removal: AnyTransition.move(edge: .leading).combined(with: .move(edge: .bottom)))
    }
}
extension Bundle {
  func decode<T: Codable>(_ file: String) -> T {
    // 1. Locate the json file
    guard let url = self.url(forResource: file, withExtension: nil) else {
      fatalError("Failed to locate \(file) in bundle.")
    }
    
    // 2. Create a property for the data
    guard let data = try? Data(contentsOf: url) else {
      fatalError("Failed to load \(file) from bundle.")
    }
    
    // 3. Create a decoder
    let decoder = JSONDecoder()
    
    // 4. Create a property for the decoded data
    guard let loaded = try? decoder.decode(T.self, from: data) else {
      fatalError("Failed to decode \(file) from bundle.")
    }
    
    // 5. Return the ready-to-use data
    return loaded
  }
}


struct StaticButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
