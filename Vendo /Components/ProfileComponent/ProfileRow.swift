//
//  ProfileRow.swift
//  Vendo
//
//  Created by feras  hababa  on 11.09.24.
//

import SwiftUI
struct ProfileRow: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding()
                    .background(Color("kSecondery"))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .foregroundColor(Color(color))

                Text(title)
                    .font(.body)

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(Color(.white))
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("kPrimary"), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle()) 
    }
       
}

