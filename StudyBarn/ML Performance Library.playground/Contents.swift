import UIKit

let mlQueue = DispatchQueue()

func makeMlRequest(image: UIImage, complete: @escaping ((_ result: String) -> Void)) {
    mlQueue.async {
        var running = 0
        var result: UIImage?
        var list = []
        if running < 4 {
            DispatchQueue.global(qos: .userInitiated) {
                // run prediction
            }
        } else if running >= 4 {
            
        }
    }
}


/* Solution */
class MlRequest {
    let mlQueue = DispatchQueue(label: "mlqueue") // have a dispatch queue for mutual exclusion, serial dispatch queue
    
    var runningTasks = 0 // need to have mutual exclusion when we access these variables
    var deferredTasks: [(UIImage, (String) -> Void)] // queue data structure to store the ones that will run later
    
    // this would run the acutal ML and produce result
    func predict(image: UIImage) -> String { "" }
    
    func runPendingTasks() {
        if let (image, complete) = deferredTasks.first { // if not empty, pop
            self.runningTasks += 1
            deferredTasks = deferredTasks.dropFirst().map { $0 }
            DispatchQueue.global(qos: .default).async {
                let result = self.predict(image: image)
                complete(result)
                self.mlQueue.async {
                    self.runningTasks -= 1
                    self.runPendingTasks()
                }
            }
        }
    }
    
    func makeMlRequest(image: UIImage, complete: @escaping (String) -> Void) {
        mlQueue.async { // bookkeeping, run any task that needs to be launched
            if self.runningTasks < 4 {
                self.runningTasks += 1
                DispatchQueue.global(qos: .default).async { // parallel queue in this closure
                    let result = self.predict(image: image)
                    complete(result)
                    // if decrement here it will cause a race condition
                    self.mlQueue.async {
                        self.runningTasks -= 1
                        self.runPendingTasks()
                    }
                }
            } else {
                self.deferredTasks.append((image, complete)) // its okay to add it here because it runs in the mlQ
            }
        }
    }
    
}
