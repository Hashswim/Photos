
import SwiftUI

struct Home: View {

    var size: CGSize
    var safeArea: EdgeInsets
    var sharedData = SharedData()

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 10) {
                    //상단 캐러셀
                    PhotosScrollView(size: size, safeArea: safeArea)

                    //하단 섹션
                    Library()
                }
            }
//            .gesture(
//                DragGesture(minimumDistance: 0, coordinateSpace: .local)
//                    .onChanged { value in
//                        let translation = value.translation.height
//                        let isScrollingUp = translation > 0
//                        let isScrollingDown = translation < 0
//                        print(isScrollingUp)
//                        // ... rest of your logic using translation, isScrollingUp, and isScrollingDown
//                    }
////                    .onEnded { value in
////                        let translation = value.translation.height
////                        let isScrollingUp = translation > 0
////                        let isScrollingDown = translation < 0
////
////                        // ... rest of your logic for gesture end
//                    )
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack() {
                        Text("Photos")
                            .font(.title.bold())
                            .foregroundStyle(Color.white)
                            .padding(safeArea)
                            .opacity(sharedData.activePage != 1 ? 0 : 1)

                        Spacer()

                        Circle()
                            .fill(.black)
                            .frame(width: 20, height: 20)
                    }
                    .frame(height: 24)
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
            .frame(width: size.width)
            .scrollDisabled(sharedData.isExpanded)
            .environment(sharedData)
        }
    }
}

#Preview {
    ContentView()
}
