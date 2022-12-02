//
//  LodingView.swift
//  whatShouldIEat_ProtoType
//
//  Created by 진태영 on 2022/12/02.
//

import SwiftUI

struct LodingView: View {
    @State private var isActive = false
    var body: some View {
        if isActive{
            ContentView()
                .environmentObject(IngredientStore())
        }else{
            Image("launchScreen")
                .resizable()
                .ignoresSafeArea()
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        self.isActive = true
                    }
                    
                }
        }
    }
}

struct LodingView_Previews: PreviewProvider {
    static var previews: some View {
        LodingView()
    }
}
