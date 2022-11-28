//
//  WebView.swift
//  whatShouldIEat_ProtoType
//
//  Created by Deokhun KIM on 2022/11/09.
//

import SwiftUI

struct WebView: View {
    var body: some View {
        SafariView(url: URL(string: "https://www.kurly.com/main")!)
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView()
    }
}
