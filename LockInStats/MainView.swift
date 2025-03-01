//
//  ContentView.swift
//  LockIn! Main Screen
//
//  Created by Morgan Harris on 10/4/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var VM:LockInVM
	@State private var timeRemaining: TimeInterval = 0
    @State private var totalTime: TimeInterval = 0  // ^ Both are used for calculating the progress bar for now. Can be used for data as well.
	@State private var timer: Timer?
	@State private var isRunning: Bool = false
	@State private var isSheetPresented: Bool = false
	@State private var isTimeSet: Bool = false // Picker starts as empty

	var body: some View {
		ZStack {
            
            
			Color.night
				.ignoresSafeArea()
			VStack(alignment: .center, spacing: 40) {
				ZStack {
					Color.cerulean
						.ignoresSafeArea()
						.opacity(0.4)
					Text("Ready, Micah?")
						.font(.title)
						.fontWidth(.condensed)
						.bold()
						.foregroundStyle(.accent)
				}
				.frame(height: 100)

				ZStack {
					Color.cerulean
						.clipShape(Circle())
					Image(.rellFull)
						.resizable()
						.scaledToFit()
						.padding(25)
					ZStack {
						Circle() // Background Bar
							.stroke(.chartGray, lineWidth: 20)

						Circle() // Progress Bar
							.trim(from: 0, to: timeRemaining / totalTime)
							.stroke(.offWhite, style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
							.rotationEffect(.degrees(-90))
							.animation(.easeInOut, value: timeRemaining)
					}
				}
				.frame(width: 300, height: 300)

				ZStack {
					Color.cerulean
					Text(formattedTime())
						.font(.system(size: 60, weight: .light))
						.foregroundStyle(.accent)
						.onTapGesture { // Basically turns this text into a button
							isSheetPresented = true
						}
				}
				.frame(height: 100)
				.sheet(isPresented: $isSheetPresented) {
					TimerSetupView(selectedHours: Int(timeRemaining / 3600),
								   selectedMinutes: Int(timeRemaining.truncatingRemainder(dividingBy: 3600) / 60),
								   selectedSeconds: Int(timeRemaining.truncatingRemainder(dividingBy: 60)),
								   onTimeSelected: { hours, minutes, seconds in
						updateTime(hours: hours, minutes: minutes, seconds: seconds) // This line calls the update time function when the user clicks on the set time button in the sheetview.
					})
					.interactiveDismissDisabled()
				}

				Button {
					isRunning.toggle()
					if isRunning {
						startTimer()
					} else {
						stopTimer()
                        
					}
				} label: {
					Text(isRunning ? "STOP" : "LOCK IN")
				}
				.disabled(!isTimeSet || timeRemaining <= 0)
				.font(.system(size: 30, weight: .black))
				.fontWidth(.condensed)
				
				.frame(width: 170, height: 66)
				.background(.cerulean)
				.clipShape(RoundedRectangle(cornerRadius: 6))

				Spacer()
			}
		}
	}

	private func formattedTime() -> String { // Displays our time in a readable format
		if !isTimeSet {
			return "--:--:--"
		} else {
			let h = Int(timeRemaining / 3600)
			let m = Int(timeRemaining.truncatingRemainder(dividingBy: 3600) / 60)
			let s = Int(timeRemaining.truncatingRemainder(dividingBy: 60))
			return String(format: "%02d:%02d:%02d", h, m, s)
		}
	}
	

	private func startTimer() {
		timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in // "_ in" and "timer in" both work here, but we can omit timer in this case because it's being set equal to it.
			if timeRemaining > 0 {
				timeRemaining -= 1 // -1 second on withTimeInterval tick ^
			} else {
				stopTimer()
			}
		}
	}

	private func stopTimer() {
		isRunning = false
        VM.addLockIns(currentLockInTime: totalTime)
		timer?.invalidate() // Kills the timer instance!
        
		timeRemaining = totalTime // Resets the formatted time back to the selected total time!
	}

	private func updateTime(hours: Int, minutes: Int, seconds: Int) {
		totalTime = TimeInterval((hours * 3600) + (minutes * 60) + seconds)
		timeRemaining = totalTime
		isTimeSet = true
	}
}

struct TimerSetupView: View {
	@State var selectedHours: Int
	@State var selectedMinutes: Int
	@State var selectedSeconds: Int
	
	let onTimeSelected: (Int, Int, Int) -> Void // Void means that this variable does not need to return a value when it's called. See the button.
	@Environment(\.dismiss) var dismiss
	
	let hoursRange = Array(0...23)
	let minutesRange = Array(0...59)
	let secondsRange = Array(0...59)

	var body: some View {
		ZStack {
			Color.night
				.ignoresSafeArea()
			VStack {
				HStack {
					Picker("Hours", selection: $selectedHours) {
						ForEach(hoursRange, id: \.self) { hour in
							Text("\(hour) hr")
						}
					}
					.pickerStyle(.wheel)
					.frame(width: 100, height: 100)
					
					Picker("Minutes", selection: $selectedMinutes) {
						ForEach(minutesRange, id: \.self) { minute in
							Text("\(minute) min")
						}
					}
					.pickerStyle(.wheel)
					.frame(width: 100, height: 100)
					
					Picker("Seconds", selection: $selectedSeconds) {
						ForEach(secondsRange, id: \.self) { second in
							Text("\(second) sec")
						}
					}
					.pickerStyle(.wheel)
					.frame(width: 100, height: 100)
				}
				.colorScheme(.dark)
				
				Button { // onClick, onTimeSelected will give a set of values, which, in turn, gets formatted into the text we see on the timer.
					onTimeSelected(selectedHours, selectedMinutes, selectedSeconds)
					dismiss()
				} label: {
					Text("Set Time")
						.font(.title2)
						.bold()
						.padding()
						.frame(width: 150, height: 50)
						.background(.cerulean)
						.foregroundStyle(.accent)
						.cornerRadius(10)
				}
			}
		}
	}
}


#Preview {
    MainView().environmentObject(LockInVM())
}
