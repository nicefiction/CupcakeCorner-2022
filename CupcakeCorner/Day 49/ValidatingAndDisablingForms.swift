/// SOURCE
/// https://www.hackingwithswift.com/books/ios-swiftui/validating-and-disabling-forms

import SwiftUI



struct ValidatingAndDisablingForms: View {
    
    // MARK: - NESTED TYPES
    // MARK: - STATIC PROPERTIES
    @State private var name: String = ""
    @State private var email: String = ""
    
    
    
    // MARK: - PROPERTY WRAPPERS
    // MARK: - PROPERTIES
    // MARK: - INITIALIZERS
    // MARK: - COMPUTED PROPERTIES
    var hasBeenDisabled: Bool {
        return name.count < 2 || email.isEmpty
    }
    
    
    var body: some View {
        Form {
            Section {
                TextField("Your name...",
                          text: $name)
                TextField("Your email...",
                          text: $email)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            }
            Section {
                Button("Save",
                       action: {
                    print("Create user.")
                })
                .disabled(hasBeenDisabled)
            }
        }
    }
    
    
    
    // MARK: - STATIC METHODS
    // MARK: - METHODS
    // MARK: - HELPER METHODS
}





// MARK: - PREVIEWS
struct ValidatingAndDisablingForms_Previews: PreviewProvider {
    
    // MARK: - STATIC PROPERTIES
    // MARK: - COMPUTED PROPERTIES
    static var previews: some View {
        
        ValidatingAndDisablingForms()
    }
}
