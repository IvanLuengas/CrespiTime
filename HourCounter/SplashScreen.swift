//
//  SplashScreen.swift
//  HourCounter
//
//  Created by Ivan Luengas on 13/11/24.
//


import SwiftUI

struct SplashScreen: View {
    @State private var showMainView = false

    var body: some View {
        VStack {
            if showMainView {
                // Aquí va tu vista principal, por ejemplo:
                MainView()
            } else {
                // Página de carga
                VStack {
                    Text("Ili")
                        .font(.system(size: 64, weight: .bold))
                        .foregroundColor(.white)
                    Text("Developments")
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
                .onAppear {
                    // Espera 2 segundos antes de mostrar la vista principal
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            showMainView = true
                        }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all) // Para que ocupe toda la pantalla
    }
}

struct MainView: View {
    var body: some View {
        ContentView()
    }
}

#Preview {
    SplashScreen()
}
