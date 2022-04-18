/// SOURCE:
/// https://www.hackingwithswift.com/books/ios-swiftui/sending-and-receiving-codable-data-with-urlsession-and-swiftui
/// iOS gives us built-in tools for sending and receiving data from the internet,
/// and if we combine it with `Codable` support
/// then it’s possible to convert Swift objects to JSON for sending,
/// then receive back JSON to be converted back to Swift objects.
/// Even better, when the request completes
/// we can immediately assign its data to properties in SwiftUI views,
/// causing our user interface to update.

import SwiftUI



struct Response: Codable {
    
    var results: Array<Result>
}





struct Result: Codable {
    
    var trackId: Int
    var trackName: String
    var collectionName: String
}





struct SendingAndReceivingCodableData: View {
    
    // MARK: - NESTED TYPES
    // MARK: - STATIC PROPERTIES
    // MARK: - PROPERTY WRAPPERS
    @State private var fetchedResults = Array<Result>.init()
    
    
    
    // MARK: - PROPERTIES
    // MARK: - INITIALIZERS
    // MARK: - COMPUTED PROPERTIES
    var body: some View {
    
        List {
            ForEach(fetchedResults,
                    id: \.trackId) { (eachResult: Result) in
                HStack {
                    Text(eachResult.trackName)
                        .font(.headline)
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(eachResult.collectionName)
                        Text("\(eachResult.trackId)")
                            .foregroundColor(.secondary)
                    }
                    .font(.subheadline)
                }
            }
        }
        .task {
            await loadData()
            /// Think of `await` as being like `try`
            /// – we’re saying we understand a sleep might happen,
            /// in the same way `try` says we acknowledge an error might be thrown.
        }
    }
    
    
    
    // MARK: - STATIC METHODS
    // MARK: - METHODS
    func loadData()
    async {
        /// `STEP 1` Create the `URL` we want to read:
        let stringURL: String = "https://itunes.apple.com/search?term=taylor+swift&entity=song"
        
        guard let _url = URL(string: stringURL)
        else {
            print("Invalid URL")
            return
        }
        /// `STEP 2` Fetching the data for that URL,
        /// ,which is where our sleep is likely to happen,
        /// and every time a sleep is possible
        /// we need to use the `await` keyword with the code we want to run:
        do {
            /// Our work is being done by the `data(from:)` method,
            /// which takes a URL
            /// and returns the Data object at that URL:.
            let (data, _) = try await URLSession.shared.data(from: _url)
            /// The return value from `data(from:) `is a tuple
            /// containing the `data` at the URL
            /// and some metadata describing how the request went.
            /// We don’t use the metadata, but we do want the URL’s data,
            /// hence the underscore
            /// – we create a new local constant for the data, and toss the metadata away.
            
            /// The last part of this method is
            ///  to convert the `Data` object into a `Response` object using `JSONDecoder`:
            let jsonDecoder = JSONDecoder.init()
            if let _decodedResponse = try? jsonDecoder.decode(Response.self,
                                                              from: data) {
                fetchedResults = _decodedResponse.results
            }
        } catch let error {
            print(error.localizedDescription)
        }
        /// `STEP 3` Decoding the result of that data into a `Response` struct.:
        
    }
    // MARK: - HELPER METHODS
}





// MARK: - PREVIEWS
struct SendingAndReceivingCodableData_Previews: PreviewProvider {
    
    // MARK: - STATIC PROPERTIES
    // MARK: - COMPUTED PROPERTIES
    static var previews: some View {
        
        SendingAndReceivingCodableData()
    }
}
