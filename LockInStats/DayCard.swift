//
//  DayCard.swift
//  LockInStats
//
//  Created by Danielle Abrams on 10/24/24.
//

import SwiftUI

struct DayCard: View {
    @State var dayName : String
    @State var color : Color
    
    var body: some View {
        VStack{
            Text(dayName)
                .font(.title)
                .bold()
                .foregroundStyle(.gray)
            Circle()
                .fill(color)
                .stroke(Color.gray, lineWidth: 5)
        }
    }
}

#Preview {
    DayCard(dayName: "Tu", color: .orange)
}
