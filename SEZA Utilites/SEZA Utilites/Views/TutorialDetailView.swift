import SwiftUI

struct TutorialDetailView: View {
    let newsBlog: NewsBlog
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(newsBlog.thumbnail)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .clipped()
            
            Text(newsBlog.title)
                .font(.largeTitle)
                .padding(.top, 10)
            
            Text(newsBlog.description)
                .font(.body)
                .padding(.top, 5)
            
            Text("Date: \(newsBlog.date)")
                .font(.subheadline)
                .padding(.top, 2)
            
            Spacer()
        }
        .padding()
        .navigationTitle(newsBlog.title)
    }
}
