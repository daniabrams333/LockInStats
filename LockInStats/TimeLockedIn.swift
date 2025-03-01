//
//  TimeLockedIn.swift
//  LockInStats
//
//  Created by Danielle Abrams on 10/8/24.
//

import Foundation
import SwiftUI
import Charts

struct TimeLockedIn: Identifiable {
    
    //whenever we are using id we want that property to come first
    
    var id = UUID()
    var dayOfWeek: String
    var timeLocked: TimeInterval
    
    
    
}


//var lockedInData: [TimeLockedIn] = [
//    
//    .init(dayOfWeek: "Mon", timeLocked: 50),
//    .init(dayOfWeek: "Tue", timeLocked: 45),
//    .init(dayOfWeek: "Wed", timeLocked: 15),
//    .init(dayOfWeek: "Thur", timeLocked: 0),
//    .init(dayOfWeek: "Fri", timeLocked: 0)
//    
//]



struct BarChart: View {
    @EnvironmentObject var VM:LockInVM
    var body: some View {
        Chart {
            ForEach(VM.lockIns) { day in
                BarMark(
                    x: .value("Day", day.dayOfWeek),
                    y: .value("Time Locked In", day.timeLocked))
            .foregroundStyle(.cerulean)
                
            }
        }
        .chartYScale(domain: [0, 80])
        .chartYAxis {
            AxisMarks(values: .automatic(desiredCount: 6))
        }
    }
}

#Preview {
    BarChart().environmentObject(LockInVM())
}
