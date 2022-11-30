import JavaScriptKit
import Foundation
import JavaScriptEventLoop


JavaScriptEventLoop.installGlobalExecutor()

Task {
    var seed: Int = 1
    while true {
        seed += 1
        try? await Task.sleep(nanoseconds: 10000000)
        demo(seed: seed)
        
    }
}

func demo(seed: Int = 1) {
    let document = JSObject.global.document
    let window = JSObject.global.window
    _ = window.console.info("began!")

    let canvas = document.getElementById("canvas").object!

    var context = canvas.getContext!("2d")

    context.strokeStyle = "black"
    context.fillStyle = "red"
    
    let _ = context.beginPath()
    _ = context.clearRect(0, 0, 1000, 1000)
    context.lineWidth = 1
    for i in 1...300 {
        let x = sin((Double(i) / Double(seed)) * 2 * 3.14) * 300 + 500
        let y = cos((Double(i) / Double(seed)) * 2 * 3.14) * 300 + 500
        let _ = context.moveTo(500 + sin(x / 3) * 100, 500)
        let _ = context.lineTo(x, y)
        context.strokeStyle = String("rgb(\(100), \((i / 300) * 255), \(i / 300 * 255))").jsValue
        let _ = context.stroke()
    }
    let _ = context.closePath()
    
}
demo()
