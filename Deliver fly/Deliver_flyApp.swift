//
//  Deliver_flyApp.swift
//  Deliver fly
//
//  Created by user on 6/16/24.
//

import SwiftUI

@main
struct Deliver_flyApp: App {
    @State private var isSplash = true
    @ObservedObject private var navigation = Navigation()
    
    var body: some Scene {
        WindowGroup {
            if isSplash {
                SplashView()
                    .onAppear(perform: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                            isSplash = false
                        }
                    })
            } else {
                NavigationStack(path: $navigation.navPath) {
                    HomeView()
                        .navigationBarBackButtonHidden(true)
                        .navigationDestination(for: Navigation.View.self) { view in
                            switch view {
                            case .restaurant(info: let info):
                                RestaurantView(restaurant: info)
                                    .navigationBarBackButtonHidden(true)
                            }
                        }
                }
                .environmentObject(navigation)
            }
        }
    }
}
