
import SwiftUI

struct Home: View {

    var size: CGSize
    var safeArea: EdgeInsets
    var sharedData = SharedData()

    @Namespace var bottomID

    @State private var viewModel: HomeViewModel = HomeViewModel()

    private var scrollObservableView: some View {
        GeometryReader { proxy in
            let offsetY = proxy.frame(in: .global).origin.y
            Color.clear
                .preference(
                    key: ScrollOffsetKey.self,
                    value: offsetY
                )
                .onAppear {
                    viewModel.setOriginOffset(offsetY)
                }
        }
        .frame(height: 0)
    }

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                scrollObservableView
                VStack(spacing: 10) {
                    //상단 캐러셀
                    PhotosScrollView(size: size, safeArea: safeArea)

                    Text("\(sharedData.mainOffset)")

                    //하단 섹션
                    Library()
                    Spacer()
                }
                .offset(y: !sharedData.isExpanded ? 0 : -sharedData.mainOffset)
            }
            .onPreferenceChange(ScrollOffsetKey.self) {
                sharedData.mainOffset = $0

                if sharedData.mainOffset > (size.height / 5) && !sharedData.isExpanded {
                    withAnimation(.smooth(duration: 0.5, extraBounce: 0)) {
                        sharedData.isExpanded = true

                        sharedData.progress = 1
                    }
                }
            }
            .overlay(alignment: .top) {
                HStack {
                    Text("Photos")
                        .font(.largeTitle.bold())
                        .foregroundStyle(Color.white)
                        .padding(safeArea)
                        .opacity(sharedData.activePage != 1 ? 0 : 1)

                    Spacer()

                    Circle()
                        .fill(.black)
                        .frame(width: 20, height: 20)
                }
                .padding()
            }
            .ignoresSafeArea()
            .scrollDisabled(sharedData.isExpanded)
            .environment(sharedData)
        }
    }
}

#Preview {
    ContentView()
}
