//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Razvan Pricop on 01.10.24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
        .shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var endGame = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .gray], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of:")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.secondary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                        .alert(scoreTitle, isPresented: $showingScore) {
                            Button("Continue", action: askQuestion)
                        } message: {
                            Text("Your score is \(userScore)")
                        }
                        .alert(scoreTitle, isPresented: $endGame) {
                            Button("Restart", action: askQuestion)
                        } message: {
                            Text("Congrats! You're done!")
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.headline.weight(.bold))
                    .padding(.horizontal, 20)
                
                Spacer()
            }
            .padding()
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer && userScore < 10 {
            scoreTitle = "Correct! That's the flag of \(countries[number])."
            userScore += 1
            showingScore = true
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])."
            showingScore = true
        }
        
        if userScore == 10 {
            reset()
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        userScore = 0
        scoreTitle = "Congrats! You've reached 10 flags!"
        endGame = true
    }
}

#Preview {
    ContentView()
}
