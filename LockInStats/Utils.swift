//
//  Utils.swift
//  LockInStats
//
//  Created by Danielle Abrams on 10/23/24.
//
import Foundation

struct DateStruct {
    static let days = ["Mo", "Tu","We","Th","Fr","Sa","Su"]
    
    func getDay(day:String) ->Int{
        for i in 0..<DateStruct.days.count {
            if day.contains(DateStruct.days[i]){
                return i
            }
        }
        return -1
    }
    func getCurrentDay()->String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE"
        let dayInWeek = dateFormatter.string(from: date)
        return dayInWeek
    }
    
    func getCurrenWeek()->[String]{
        let day = getCurrentDay()
        let index = getDay(day: day)
        var week : [String] = []
        let i = index
        for i in 0..<DateStruct.days.count {
            if(i>=index){
                week.append(DateStruct.days[i])
            }
        }
        for i in 0..<DateStruct.days.count{
            if(i<index){
                week.append(DateStruct.days[i])
            }
        }
        return week 
    }
}
