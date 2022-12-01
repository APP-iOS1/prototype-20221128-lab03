//
//  ImagePicker.swift
//  whatShouldIEat_ProtoType
//
//  Created by 진태영 on 2022/12/01.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable{
    @Binding var imagePickerVisible: Bool
    @Binding var selectedImage: Image?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController{
        let picker = UIImagePickerController()
        
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        // ....
    }
    
    //무슨 이벤트가 걸리거든 여기로 알려다오
    func makeCoordinator() -> Coordinator {
        return Coordinator(imagePickerVisible: $imagePickerVisible, selectedImage: $selectedImage)
    }

    
    // class 여기 안에 선언하면 여기서만 사용가능
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var imagePickerVisible: Bool
        @Binding var selectedImage: Image?
        // 타입 자체가 옵셔널 Image
        // 실제로 값을 바꿔주는건 여기에서 할거니깐 binding 걸어줌
        
        init(imagePickerVisible: Binding<Bool>, selectedImage: Binding<Image?>) {
            _imagePickerVisible = imagePickerVisible
            _selectedImage = selectedImage
        }
        //사진 골랐을 때 , 취소했을 때, 실패했을 때
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            imagePickerVisible = false
        }
        
        // 사진 가져오는게 끝났을 때
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            // 이런 패턴이 있다~
            let image: UIImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            selectedImage = Image(uiImage: image)
            
            imagePickerVisible = false
            
            
        }
        
    }
}
