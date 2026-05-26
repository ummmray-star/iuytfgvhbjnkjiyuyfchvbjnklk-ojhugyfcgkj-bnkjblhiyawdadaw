import SwiftUI

struct PhotoCaptureView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = PhotoMealViewModel()
    @State private var showingImagePicker = false
    let onSave: () -> Void

    var body: some View {
        VStack(spacing: FGSpacing.lg) {
            if let image = viewModel.capturedImage {
                if viewModel.isAnalyzing {
                    VStack(spacing: FGSpacing.lg) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 300)
                            .clipShape(RoundedRectangle(cornerRadius: FGSpacing.cardRadius, style: .continuous))

                        ProgressView("Analyzing your meal...")
                            .font(FGTypography.body)
                            .tint(FGColors.accent)
                    }
                    .padding(FGSpacing.screenPadding)
                } else if let result = viewModel.analysisResult {
                    PhotoResultView(
                        image: image,
                        result: result,
                        mealType: viewModel.mealType,
                        onSave: {
                            if let meal = viewModel.buildMealEntry() {
                                modelContext.insert(meal)
                                onSave()
                            }
                        },
                        onRetake: {
                            viewModel.reset()
                        }
                    )
                }
            } else {
                Spacer()

                VStack(spacing: FGSpacing.xl) {
                    Image(systemName: "camera.fill")
                        .font(.system(size: 64, weight: .light))
                        .foregroundStyle(FGColors.accent.opacity(0.6))

                    Text("Take a photo of your meal")
                        .font(FGTypography.headline)
                        .foregroundStyle(FGColors.textPrimary)

                    Text("We'll help identify what's in it.")
                        .font(FGTypography.body)
                        .foregroundStyle(FGColors.textSecondary)

                    FGButton("Open Camera", icon: "camera.fill") {
                        showingImagePicker = true
                    }
                    .frame(maxWidth: 260)
                }

                Spacer()
            }
        }
        .background(FGColors.background)
        .navigationTitle("Photo Meal")
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $viewModel.capturedImage)
                .onDisappear {
                    if viewModel.capturedImage != nil {
                        Task { await viewModel.analyzePhoto() }
                    }
                }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.dismiss) private var dismiss

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        picker.allowsEditing = false
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}
