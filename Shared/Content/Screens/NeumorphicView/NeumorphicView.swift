import SwiftUI

func HapticFeedback(type: UINotificationFeedbackGenerator.FeedbackType = .success) {
    UINotificationFeedbackGenerator().notificationOccurred(type)
}

func ImpactFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .heavy) {
    UIImpactFeedbackGenerator(style: style).impactOccurred()
}

struct NeumorphicView: View {
    var body: some View {
        VStack (spacing: 70) {
            CircularPayButton()
            RectangleButton()
            CircularThemeButton()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
        .edgesIgnoringSafeArea(.all)
        .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0))
    }
    
   private struct RectangleButton: View {
        @State var tap = false
        @State var press = false
        
        var body: some View {
            Text("Button")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .frame(width: 200, height: 60)
                .background(
                    ZStack {
                        Color(press ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1))
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .foregroundColor(Color(press ? #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                            .blur(radius: 4)
                            .offset(x: -8, y: -8)
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9019607843, green: 0.9294117647, blue: 0.9882352941, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .padding(2)
                            .blur(radius: 2)
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay(
                    HStack {
                        let ICON_COLOR = Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))
                        
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 24, weight: .light))
                            .foregroundColor(Color.white.opacity(press ? 0 : 1))
                            .frame(width: press ? 64 : 54, height: press ? 4 : 50)
                            .background(ICON_COLOR)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: ICON_COLOR.opacity(0.3), radius: 10, x: 10, y: 10)
                            .offset(x: press ? 70 : -10, y: press ? 16 : 0)
                        
                        Spacer()
                    }
                )
                .shadow(color: Color(press ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 20, x: 20, y: 20)
                .shadow(color: Color(press ? #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
                .scaleEffect(tap ? 1.2 : 1)
                .gesture(
                    LongPressGesture(minimumDuration: 0.5, maximumDistance: 10).onChanged { value in
                        self.tap = true
                        ImpactFeedback()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.tap = false
                        }
                    }
                    .onEnded { value in
                        self.press.toggle()
                        HapticFeedback()
                    }
                )
        }
    }
    
    
    private struct CircularThemeButton: View {
        @State var tap = false
        @State var press = false
        
        var body: some View {
            let SIZE: CGFloat = 100
            ZStack {
                Image(systemName: "sun.max")
                    .font(.system(size: 44, weight: .light))
                    .offset(x: press ? -90 : 0, y: press ? -90: 0)
                    .rotation3DEffect(.degrees(press ? 20 : 0),axis: (x: 10, y: -10, z: 0))
                
                Image(systemName: "moon")
                    .font(.system(size: 44, weight: .light))
                    .offset(x: press ? 0 : 090, y: press ? 0: 90)
                    .rotation3DEffect(.degrees(press ? 0 : 20),axis: (x: -10, y: 10, z: 0))
            }
            .frame(width: SIZE, height: SIZE)
            .background(
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color(press ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), Color(press ?  #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1): #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    
                    Circle()
                        .stroke(Color.clear, lineWidth: 10)
                        .shadow(color: Color(press ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 3, x: -5, y: -5)
                    
                    Circle()
                        .stroke(Color.clear, lineWidth: 10)
                        .shadow(color: Color(press ? #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 3, x: 3, y: 3)
                }
                
            )
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .shadow(color: Color(press ? #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
            .shadow(color: Color(press ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 20, x: 20, y: 20)
            .scaleEffect(tap ? 1.2 : 1)
            .gesture(
                LongPressGesture()
                    .onChanged { value in
                        self.tap = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.tap = false
                        }
                    }
                    .onEnded { value in
                        self.press.toggle()
                    }
            )
        }
    }

    private struct CircularPayButton: View {
       @GestureState var tap = false
       @State var press = false
       
       var body: some View {
           let SIZE: CGFloat = 120
           let INNER_SIZE: CGFloat = 88
           ZStack {
               Image("fingerprint")
                   .opacity(press ? 0 : 1)
                   .scaleEffect(press ? 0 : 1)
               
               Image("fingerprint-2")
                   .clipShape(Rectangle().offset(y: tap ? 0 : 50))
                   .animation(.easeInOut)
                   .opacity(press ? 0 : 1)
                   .scaleEffect(press ? 0 : 1)
               
               Image(systemName: "checkmark.circle.fill")
                   .font(.system(size: 44, weight: .light))
                   .foregroundColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
                   .opacity(press ? 1 : 0)
                   .scaleEffect(press ? 1 : 0)
           }
           .frame(width: SIZE, height: SIZE)
           .background(
               ZStack {
                   LinearGradient(gradient: Gradient(colors: [Color(press ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), Color(press ?  #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1): #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                   
                   Circle()
                       .stroke(Color.clear, lineWidth: 10)
                       .shadow(color: Color(press ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 3, x: -5, y: -5)
                   
                   Circle()
                       .stroke(Color.clear, lineWidth: 10)
                       .shadow(color: Color(press ? #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 3, x: 3, y: 3)
               }
               
           )
           .clipShape(Circle())
           .overlay(
               Circle()
                   .trim(from: tap ? 0.001 : 1, to: 1)
                   .stroke(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing), style: StrokeStyle(lineWidth: 5, lineCap: .round))
                   .frame(width: INNER_SIZE, height: INNER_SIZE)
                   .rotationEffect(.degrees(90))
                   .rotation3DEffect(.degrees(180), axis: (x: 1, y: 0, z: 0))
                   .shadow(color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 5, x: 3, y: 3)
                   .animation(.easeInOut)
           )
           .shadow(color: Color(press ? #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
           .shadow(color: Color(press ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 20, x: 20, y: 20)
           .scaleEffect(tap ? 1.2 : 1)
           .gesture(
               LongPressGesture()
                   .updating($tap) { currentState, gestureState, transaction in
                       gestureState = currentState
                   }
                   .onEnded { value in
                       self.press.toggle()
                   }
           )
       }
   }

}
  
