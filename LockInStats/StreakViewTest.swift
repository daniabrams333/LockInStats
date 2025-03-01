//
//  StreakViewTest.swift
//  LockInStats
//
//  Created by Danielle Abrams on 10/23/24.
//

import SwiftUI

struct StreakViewTest: View {
    @State var streakDayCount : Int = 1
    @State private var color = Color.night
    var body: some View {
        NavigationStack{
            VStack {
                ZStack{
                    Image("LockImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                        .padding(.bottom,130)
                    Text("\(streakDayCount)")
                        .font(.system(size: 100))
                        .bold()
                }
            }
            Text("day streak!")
                .font(.system(size: 40))
                .bold()
                .foregroundStyle(.cerulean)
                .padding(.top,-130)
            
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray,lineWidth: 2)
                .frame(width:
                        UIScreen.main.bounds.width-20, height:200)
            
            VStack{
                let dateObject = DateStruct()
                let day = dateObject.getCurrentDay()
                let index = dateObject.getDay(day: day)
                HStack{
                  //  let week = DateStruct().getCurrentWeek()
                   // ForEach(week.indices,id:\.self){i in
                      //  let color = i<streakDayCount ? Color.cerulean : Color.gray }
                }
            }
        }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    StreakViewTest()
}
