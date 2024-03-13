//
//  SearchBar.swift
//  StudyBarn
//
//  Created by Ann Yip on 2/26/24.
//

import SwiftUI

struct SearchBar: View {
    var body: some View {
        ZStack {
            HStack {
                Image(systemName: "magnifyingglass")
                Text("Filter")
                    .padding(.leading, 4)
                    .font(.custom("Futura", size: 18))
                    .opacity(0.5)
                Spacer()
            }
            .padding()
            .background(Color("SearchBar").opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .overlay {
                RoundedRectangle(cornerRadius: 40)
                    .stroke(lineWidth: 0.5)
                    .foregroundStyle(Color(.systemGray4))
                    .cornerRadius(40)
                    .shadow(color: .black.opacity(0.4), radius:2)
            }
            .padding()
        }
    }
}

#Preview {
    SearchBar()
}
