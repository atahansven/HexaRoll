//
//  ContentView.swift
//  HexaRolling
//
//  Created by Atahan Akyüz on 2.01.2024.
//

import SwiftUI
import Combine


var shakeMessenger = PassthroughSubject<Void,Never>()

struct ContentView: View {
    @State var number=1
    @State var rollTracker=0
    
    var body: some View {
        GeometryReader{ geometry in
            
            ShakeHandlerRepresentable()
            
            VStack {
                Spacer()
                
                Image("\(number)")
                    .scaleEffect(0.5)
                
                Text("\(number)")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .foregroundColor(.white)
                Text("You rolled " + "\(rollTracker)" + " times." )
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .foregroundColor(.yellow)
                Spacer()
                
                Button{
                    roll()
                } label:{
                    Text("ROLL")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.blue)
                        .padding(.vertical)
                    
                }
                .frame(width: geometry.size.width * 0.8)
                .background(Color.green)
                .cornerRadius(30)
                .padding(.bottom,50)
                
            }
            .frame(width: geometry.size.width,height: geometry.size.height)
            .background(LinearGradient(
                colors:[.purple , .blue],
                startPoint:.top,
                endPoint:.bottom
            ))
                
            }
            .ignoresSafeArea()
            .onReceive(shakeMessenger) { _ in
                roll()
            }
            
        }
    
    func roll(){
        number = .random(in: 1...6)
        rollTracker+=1
    }
    
 }

    

    
    struct ShakeHandlerRepresentable: UIViewControllerRepresentable{
        func makeUIViewController(context: Context) -> ShakeHandler { ShakeHandler()}
       
  
        func updateUIViewController(_ uiViewController: ShakeHandler, context: Context) {}
            
        
        
    }
    
    class ShakeHandler: UIViewController{
        override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
            if motion == .motionShake
            {
                shakeMessenger.send()
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider{
        static var previews: some View{
            ContentView()
        }
    }

