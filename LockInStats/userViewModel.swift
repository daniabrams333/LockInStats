//
//  userViewModel.swift
//  LockInStats
//
//  Created by Danielle Abrams on 10/24/24.
//
//Adding to Github
import Foundation

class LockInVM:ObservableObject {
    
    @Published var name = ""
    @Published var lockIns = [TimeLockedIn]()
    
    func addLockIns(currentLockInTime:TimeInterval) {
        
        let newDate = Date()
        let formattedDate = newDate.formatted(Date.FormatStyle().weekday(.abbreviated))
        
        let newLockIn = TimeLockedIn( dayOfWeek: formattedDate, timeLocked: currentLockInTime)
        
        lockIns.append(newLockIn)
        
        print(lockIns)
    }
    
    
    
}
