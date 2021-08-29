//
//  AddItem.swift
//  QuickrClone
//
//  Created by Aarish Rahman on 25/08/21.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct AddItem: View {
    @State var showActionSheet = false
    //    @State var showImagePicker = false
    
    @State var sourceType:UIImagePickerController.SourceType = .camera
    
    @State var upload_image:UIImage?
    @State var download_image:UIImage?
    @State var showImagePicker: Bool = false
    @State var title = ""
    @State var description = ""
    //    @State var image: UIImage?
    var body: some View {
        NavigationView{
            VStack {
                if upload_image != nil {
                    Image(uiImage: upload_image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 330, height: 250)
                        .shadow(color: Color.gray.opacity(0.3), radius: 22, x: 0, y: 10 )
                }
                else{
                    Image(systemName: "photo.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 330, height: 250)
                        .shadow(color: Color.gray.opacity(0.3), radius: 22, x: 0, y: 10 )
                        .foregroundColor(.gray)
                }
                Spacer()
                Form{
                TextField("Title",text: $title)
                    Section(header: Text("Description")){
                TextEditor(text: $description)
                    .frame(width: 100, height: 200, alignment: .center)
                    
                    }
                }
            }
            .onAppear(){
                if let upload_image = self.upload_image{
                    uploadImage(image: upload_image)
                }
                else{
                    print("couldnt upload")
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePickerView(sourceType: .photoLibrary) { image in
                    self.upload_image = image
                }
            }
            .navigationBarItems(trailing:
                                    Button("\(Image(systemName: "plus.circle"))") {
                                        self.showImagePicker.toggle()
                                        
                                    })
            .navigationBarTitle("Items",displayMode: .inline)
                  
            
        }
    }
}
func uploadImage(image:UIImage){
    if let imageData = image.jpegData(compressionQuality: 1){
        let storage = Storage.storage()
        storage.reference().child("temp").putData(imageData, metadata: nil){
            (_, err) in
            if let err = err {
                print("an error has occurred - \(err.localizedDescription)")
            } else {
                print("image uploaded successfully")
            }
        }
    } else {
        print("coldn't unwrap/case image to data")
    }
}
struct AddItem_Previews: PreviewProvider {
    static var previews: some View {
        AddItem()
    }
}
