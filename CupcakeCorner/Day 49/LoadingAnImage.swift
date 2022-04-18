/// SOURCE
/// https://www.hackingwithswift.com/books/ios-swiftui/loading-an-image-from-a-remote-server

import SwiftUI



struct LoadingAnImage: View {
    
    // MARK: - NESTED TYPES
    // MARK: - STATIC PROPERTIES
    // MARK: - PROPERTY WRAPPERS
    // MARK: - PROPERTIES
    let imageURLString: String = "https://hws.dev/img/logo.png"
    let badURLString: String = "https://hws.dev/img/bad.png"
    
    
    
    // MARK: - INITIALIZERS
    // MARK: - COMPUTED PROPERTIES
    var body: some View {
    
//        AsyncImage(url: URL(string: imageURLString))
        /// We can tell SwiftUI ahead of time that we’re trying to load a 3x scale image:
//        AsyncImage(url: URL(string: imageURLString),
//                   scale: 3.0)
        
        
        ///To adjust our image,
        ///you need to use a more advanced form of `AsyncImage`
        /// that passes us the final image view
        /// once it’s ready, which we can then customize as needed:
//        AsyncImage(url: URL(string: imageURLString)) { (image) in
//            image
//                .resizable()
//        } placeholder: {
//            // Color.red
//            ProgressView.init()
//        }
//        .frame(width: 200.0,
//               height: 200.0)
        
        
        /// If you want complete control over your remote image,
        /// there’s a third way of creating `AsyncImage`
        /// that tells us whether the image was loaded,
        /// hit an error,
        /// or hasn’t finished yet:
        AsyncImage(url: URL(string: badURLString)) { (asynchImagePhase: AsyncImagePhase) in
            if let _image = asynchImagePhase.image {
                _image
                    .resizable()
                    .scaledToFit()
            } else if asynchImagePhase.error != nil {
                Text("There was a problem loading the image.")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200.0,
               height: 200.0)
    }
    
    
    
    // MARK: - STATIC METHODS
    // MARK: - METHODS
    // MARK: - HELPER METHODS
}





// MARK: - PREVIEWS
struct LoadingAnImage_Previews: PreviewProvider {
    
    // MARK: - STATIC PROPERTIES
    // MARK: - COMPUTED PROPERTIES
    static var previews: some View {
        
        LoadingAnImage()
    }
}
