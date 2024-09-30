//
//  ImageSliderView.swift
//  Vendo
//
//  Created by feras  hababa  on 23.08.24.
//

import SwiftUI

struct ImageSliderView: View {
    @State private var cuurentIdex = 0
    var slides: [String] = ["Sale3","Adidas","jewellery1","Schuhe","Monitor","Monitor2"]
    var body: some View {
        ZStack(alignment: .bottomLeading){
            ZStack(alignment: .trailing){
                Image(slides[cuurentIdex])
                    .resizable()
                    .frame(maxWidth:.infinity)
                    .frame(height:  170)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
            }
            HStack{
                ForEach(0..<slides.count, id: \.self) { index in
                    Circle()
                        .fill(self.cuurentIdex == index ? Color("kPrimary") : Color("kSecondery"))
                        .frame(width: 0, height: 0)
                    
                }
                
            }
            .padding()
        }
        .padding()
        .onAppear{
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true){timer in
                if cuurentIdex + 1 == slides.count{
                    cuurentIdex = 0
                }else {
                    cuurentIdex += 1
                }
            }
        }
    }
}

#Preview {
    ImageSliderView()
}
