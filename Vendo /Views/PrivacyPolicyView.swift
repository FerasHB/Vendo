//
//  PrivacyPolicyView.swift
//  Vendo
//
//  Created by feras  hababa  on 23.09.24.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Privacy Policy")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("""
                At Vendo, we value your privacy and are committed to protecting your personal information. This Privacy Policy outlines how we collect, use, and protect your data when you use our app.
                
                **1. Data Collection:**
                We collect personal information such as your name, email, and order history to provide you with a personalized experience.

                **2. Data Usage:**
                Your data is used to improve your experience, including personalized recommendations and order tracking.

                **3. Data Sharing:**
                We do not share your data with third parties without your consent, except as required by law.

                **4. Security:**
                We use industry-standard measures to ensure your data is protected.

                For more details, please visit our [website](https://www.vendoapp.com/privacy).
                """)
                .font(.body)
                .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Privacy Policy")
        .background(Color(UIColor.systemGray6))
    }
}
