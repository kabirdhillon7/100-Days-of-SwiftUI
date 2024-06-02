//
//  AddView.swift
//  M5. EventContacts
//
//  Created by Kabir Dhillon on 5/31/24.
//

import PhotosUI
import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State private var contactImage: Image?
    @State private var contactPhotoPicker: PhotosPickerItem?
    @State private var name: String = ""
    
    var onSave: (Contact) -> Void
    
    init(onSave: @escaping (Contact) -> Void) {
        self.onSave = onSave
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                contactImage?
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                
                PhotosPicker("Select from Photo Library", selection: $contactPhotoPicker, matching: .images)
                
                TextField("Name", text: $name, prompt: Text("Enter a name"))
                Spacer()
            }
            .navigationTitle("Add Contact")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            .onChange(of: contactPhotoPicker) {
                Task {
                    if let loaded = try? await contactPhotoPicker?.loadTransferable(type: Image.self) {
                        contactImage = loaded
                    } else {
                        print("Failed")
                    }
                }
            }
            .overlay(alignment: .bottom, content: {
                Button {
                    Task {
                        if let data = try? await contactPhotoPicker?.loadTransferable(type: Data.self) {
                            let contact = Contact(
                                id: UUID(),
                                photo: data,
                                name: name
                            )
                            
                            onSave(contact)
                            dismiss()
                        }
                    }
                } label: {
                    Text("Done")
                        .frame(maxWidth: .infinity)
                }
                .disabled(name.isEmpty && contactImage == nil)
                .buttonStyle(.borderedProminent)
                .padding()
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Cancel")
                            .foregroundStyle(.red)
                    })
                }
            } 
        }
    }
}

#Preview {
    NavigationStack {
        AddView() { _ in }
    }
}
