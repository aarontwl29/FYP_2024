import SwiftUI

struct VoiceFilePickerView: View {
    @Binding var voiceFileURL: URL?
    @State private var showFilePickerView = false
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        VStack {
            if let voiceFileURL = voiceFileURL {
                Text(voiceFileURL.lastPathComponent)
            } else {
                Button("Select Voice File") {
                    showFilePickerView = true
                }
            }
        }
        .sheet(isPresented: $showFilePickerView) {
            VoiceFileUploadView(voiceFileURL: $voiceFileURL, onDismiss: {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}


struct VoiceFileUploadView: UIViewControllerRepresentable {
    @Binding var voiceFileURL: URL?
    var onDismiss: () -> Void

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.audio], asCopy: true)
        documentPicker.delegate = context.coordinator
        return documentPicker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let parent: VoiceFileUploadView

        init(_ parent: VoiceFileUploadView) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            if let url = urls.first {
                parent.voiceFileURL = url
            }
            parent.onDismiss()
        }

        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.onDismiss()
        }
    }
}

