//import Intents
//
//class IntentHandler: INExtension, SelectButtonIntentHandling {
//
//    func handle(intent: SelectButtonIntent, completion: @escaping (SelectButtonIntentResponse) -> Void) {
//        // Get the button name from the intent
//        guard let buttonName = intent.buttonName else {
//            completion(SelectButtonIntentResponse(code: .failure, userActivity: nil))
//            return
//        }
//
//        // Find the button with the matching name and press it
//        if let button = self.viewController()?.buttons.first(where: { $0.title == buttonName }) {
//            button.sendActions(for: .touchUpInside)
//            completion(SelectButtonIntentResponse(code: .success, userActivity: nil))
//        } else {
//            completion(SelectButtonIntentResponse(code: .failure, userActivity: nil))
//        }
//    }
//
//    private func viewController() -> ViewController? {
//        return self.extensionContext?.hostedViewControllers.first as? ViewController
//    }
//}
