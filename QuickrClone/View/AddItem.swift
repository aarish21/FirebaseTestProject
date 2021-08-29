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
    @StateObject var viewModel = ListsViewModel()
    @Environment (\.presentationMode) var presentationMode
    @State var upload_image:UIImage?
    @State var download_image:UIImage?
    @State var showImagePicker: Bool = false
    
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
                        .frame(width: 300, height: 250)
                        .foregroundColor(.gray)
                }
                Button(action: {
                    if let upload_image = self.upload_image{
                        uploadImage(image: upload_image)
                    }
                    else{
                        print("couldnt upload")
                    }

                }){
                    Text("Upload Image")
                }
                Spacer()
                Form{
                    TextField("Title",text: $viewModel.list.name)
                        .disableAutocorrection(true)
                        
                    TextField("Category", text: $viewModel.list.category)
                        .disableAutocorrection(true)
                    Section(header: Text("Description")){
                        TextEditor(text: $viewModel.list.description)
                            .disableAutocorrection(true)
                            
                    .frame(width: 100, height: 200, alignment: .center)
                        
                    }
                }
            }
            .onAppear(){
                viewModel.list.sender = Auth.auth().currentUser?.email ?? ""
                
              
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePickerView(sourceType: .photoLibrary) { image in
                    self.upload_image = image
                }
            }
            .navigationBarItems(leading:
                                    Button(action: {doneTapped()}, label: {
                                        Text("Done")
                                    }),
                                trailing:
                                    Button("\(Image(systemName: "plus.circle"))") {
                                        self.showImagePicker.toggle()
                                        
                                    })
            .navigationBarTitle("Items",displayMode: .inline)
                  
            
        }
    }
    func doneTapped(){
        viewModel.save()
        dismiss()
    }
    func dismiss(){
        presentationMode.wrappedValue.dismiss()
    }
    func uploadImage(image:UIImage){
        if let imageData = image.jpegData(compressionQuality: 1){
            let filename = UUID().uuidString
            let storage = Storage.storage().reference(withPath: "/images/\(filename)")
           
            storage.putData(imageData, metadata: nil){
                (_, err) in
                if let err = err {
                    print("an error has occurred - \(err.localizedDescription)")
                } else {
                    storage.downloadURL { (url, err) in
                        if let imageUrl = url?.absoluteString{
                            viewModel.list.imgUrl = imageUrl
                        }
                        print("image upload successfull")
                    }
                }
            }
        } else {
            print("couldn't unwrap/case image to data")
        }
    }
}

struct AddItem_Previews: PreviewProvider {
    static var previews: some View {
        AddItem()
    }
}
