// Paste into Playgrounds!
import SwiftUI
import PlaygroundSupport

//struct ComplexView: View {
//    var body: some View {
//        VStack(alignment: .center, spacing: 20) {
//            // Headline ---------------
//            Text("Joker Robs Gotham Bank!")
//                .padding([.leading, .trailing])
//                .font(.largeTitle)
//                .foregroundColor(.teal.opacity(0.9))
//            // Divider ------------------
//            Rectangle().frame(width: 200, height: 10)
//                .foregroundColor(.red.opacity(0.7))
//            Text("Batman Ignores Batsignal").font(.title)
//                .foregroundColor(.indigo.opacity(0.9))
//            Rectangle().frame(width: 200, height: 10)
//                .foregroundColor(.blue.opacity(0.7))
//            Text("Catwoman Cavorts with Robin").font(.title2)
//                .foregroundColor(.brown.opacity(1.0))
//            Rectangle().frame(width: 300, height: 6)
//                .foregroundColor(.orange.opacity(0.7))
//        }
//        .frame(width: .infinity, height: 300)
//    }
//}
//
//// Run this line in Playgrounds
//PlaygroundPage.current.setLiveView( ComplexView() )




// Create a reusable Lego brick.
// You'll want to reuse this in your applications.
// Easy to paste this into a new application!
struct DividerView: View {
    // Common Properties with sensible default values
    var width:   CGFloat = 200     // provide a default
    var height:  CGFloat = 10      // nice default
    var color:   Color   = .black  // common default
    var opacity: CGFloat = 0.8     // default

    // This is what gets drawn to your screen
    var body: some View {
        // Create a rectangle using the parameters you pass in.
        Rectangle()
            .frame(width: width, height: height)
            .foregroundColor( color.opacity(opacity))
    }
}


// Create another Lego brick for Headlines
// Easy to paste this into a new application!
struct HeadlineView: View {
    var headline         = "Placeholder"     // provide a default
    var style            = Font.largeTitle   // nice default
    var color:   Color   = .black            // common default
    var opacity: CGFloat = 1.0               // default

    // This is what is drawn to your screen
    var body: some View {
        // Create a headline using the parameters you pass in.
        Text( headline )
            .font( style )
            .foregroundColor( color.opacity(opacity)) // You specify this look
    }
}


// Simplify your view by using your DividerView and your HeadlineView
struct RefactoredView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
        // Create your view by snapping together custom Lego bricks. Easy!
            HeadlineView(headline: "Joker Robs Gotham Bank", style: .largeTitle, color: .teal, opacity: 0.9)
            DividerView(width: 200, height: 15, color: .red, opacity: 0.7)
            HeadlineView(headline: "Batman Ignores Batsignal", style: .title, color: .indigo, opacity: 0.9)
            DividerView(color: .blue, opacity: 0.7)
            HeadlineView(headline: "Batwoman Dines with Alfred", style: .title2, color: .brown)
            DividerView(width: 300, height: 3, color: .orange, opacity: 0.7)
        }
        .frame(width: .infinity, height: 300)
    }
}

// Run this line in Playgrounds
PlaygroundPage.current.setLiveView( RefactoredView() )
