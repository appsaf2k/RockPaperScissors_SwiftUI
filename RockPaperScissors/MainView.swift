//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by @andreev2k on 29.08.2022.
//

import SwiftUI

struct MainView: View {
    @State private var array = ["rock", "paper", "scissors"]
    @State private var pickTitle = ""
    @State private var randomArray = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingCard = false
    
    @State private var name = ["Трус", "Балбес", "Бывалый"]
    @State private var randomName = Int.random(in: 0...2)
    @State private var score2 = 0
    @State private var showingAlert = false
    
    @State private var phrase = ["Сыграем?", "Ну, давай-давай", "Верь в себя", "Тебе точно повезет", "Твой ход", "Ты лучший", "Хочешь ещё?", "Ходи давай", "Может сдашься?", "Тебе не подебить", "Наивный", "Ты худший", "Лузер", "И как тебе?", "Ты красавчик"]
    @State private var randomPhrase = Int.random(in: 0...14)

    var body: some View {
        ZStack {
            LinearGradient(colors: [.black, .gray, .black, .gray], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text("\(name[randomName]): \(score2)")
                        .font(.title3)
                    .foregroundStyle(.white).opacity(0.8)
                    Spacer()
                    Text("Твой счет: \(score)")
                        .font(.title3)
                    .foregroundStyle(.white).opacity(0.8)
                }
                .padding(.horizontal)
                
                Spacer()
                VStack {
                    Image(showingCard ? array[randomArray] : "clear")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(15)
                        .padding(.top, 40)
                        .padding(.horizontal, 40)
                        .shadow(color: .white, radius: 10, x: 0, y: 0)
                        .animation(.easeOut(duration: 0.6), value: showingCard)
                        .onTapGesture {
                            randomArray = Int.random(in: 0...2)
                            showingCard = false
                        }
                    
                    Text(showingCard ? pickTitle : phrase[randomPhrase])
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white).opacity(0.7)
                        .padding(.bottom, 10)
                        .opacity(showingAlert ? 0 : 1)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .white, radius: 10, x: 0, y: 0)
                
                Spacer()
                VStack {
                    Text(showingCard ? "ЖМИ НА КАРТОЧКУ, СВЕРХУ" : "ВЫБЕРИ КАРТОЧКУ")
                        .opacity(showingAlert ? 0 : 1)
                        .foregroundColor(.white)
                    HStack {
                        ForEach(0..<3) { number in
                            Button {
                                mySelect(number)
                            } label: {
                                Image(array[number])
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                    .shadow(color: .white, radius: 5, x: 0, y: 0)
                                    .padding(.horizontal, 10)
                                    .opacity(showingAlert ? 0 : 1)
                                    .animation(.easeOut, value: showingCard)
                            }
                            .disabled(showingCard)
                        }
                    }
                }
            }
            .alert("Игра окончена", isPresented: $showingAlert) {
                Button("Заново", action: reset)
            } message: {
                Text("Ты \(pickTitle)")
            }

        }
    }
    
    func mySelect(_ number: Int) {
        if number == randomArray {
            pickTitle = "Выиграл!"
            score += 1
        } else {
            pickTitle = "Проиграл!"
            score2 += 1
        }
        if score == 5 || score2 == 5 {
            showingAlert = true
        }
        showingCard = true
        randomPhrase = Int.random(in: 0...14)
    }
    
    func reset() {
        name.shuffle()
        randomName = Int.random(in: 0...2)
        score = 0
        score2 = 0
        showingCard = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
