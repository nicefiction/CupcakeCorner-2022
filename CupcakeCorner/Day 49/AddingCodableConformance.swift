/// SOURCE:
/// https://www.hackingwithswift.com/books/ios-swiftui/adding-codable-conformance-for-published-properties

import SwiftUI



class Human: ObservableObject,
             Codable {
    
    // MARK: - NESTED TYPES
    /// STEP 1
    /// Tell Swift which properties should be loaded and saved:
    enum CodingKeys: CodingKey {
        case name
    }
    
    
    
    // MARK: - STATIC PROPERTIES
    // MARK: - PROPERTY WRAPPERS
    @Published var name: String = "Dorothy Gale"
    
    
    
    // MARK: - PROPERTIES
    // MARK: - INITIALIZERS
    /// STEP 2:
    /// Create a custom initializer that will be given some sort of container,
    /// and use that to read values for all our properties.
    required init(from decoder: Decoder)
    throws {
        /// This means “this data should have a container
        /// where the keys match whatever cases we have in our `CodingKeys` enum:
        let container = try decoder.container(keyedBy: CodingKeys.self)
        /// Finally, we can read values directly from that container by referencing cases in our enum:
        name = try container.decode(String.self,
                                    forKey: CodingKeys.name)
    }
    
    
    
    // MARK: - COMPUTED PROPERTIES
    // MARK: - STATIC METHODS
    // MARK: - METHODS
    func encode(to encoder: Encoder)
    throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name,
                             forKey: CodingKeys.name)
    }
    
    
    
    // MARK: - HELPER METHODS
}



struct AddingCodableConformance: View {
    
    // MARK: - NESTED TYPES
    // MARK: - STATIC PROPERTIES
    // MARK: - PROPERTY WRAPPERS
    // MARK: - PROPERTIES
    // MARK: - INITIALIZERS
    // MARK: - COMPUTED PROPERTIES
    var body: some View {
    
        Text("Hello, world!")
    }
    
    
    
    // MARK: - STATIC METHODS
    // MARK: - METHODS
    // MARK: - HELPER METHODS
}





// MARK: - PREVIEWS
struct AddingCodableConformance_Previews: PreviewProvider {
    
    static var previews: some View {
        
        AddingCodableConformance()
    }
}
