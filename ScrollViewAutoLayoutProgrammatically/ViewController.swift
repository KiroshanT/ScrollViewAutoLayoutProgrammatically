//
//  ViewController.swift
//  ScrollViewAutoLayoutProgrammatically
//
//  Created by Kiroshan Thayaparan on 6/21/22.
//

import UIKit

class ViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "swift")
        view.contentMode = .scaleAspectFit
        return view
    }()
    let labelTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .darkGray
        view.text = "Swift"
        return view
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = false
        //view.isUserInteractionEnabled = false
        view.textColor = .darkGray
        view.text = "Modern\n\nSwift is the result of the latest research on programming languages, combined with decades of experience building Apple platforms. Named parameters are expressed in a clean syntax that makes APIs in Swift even easier to read and maintain. Even better, you don’t even need to type semi-colons. Inferred types make code cleaner and less prone to mistakes, while modules eliminate headers and provide namespaces. To best support international languages and emoji, Strings are Unicode-correct and use a UTF-8 based encoding to optimize performance for a wide-variety of use cases. Memory is managed automatically using tight, deterministic reference counting, keeping memory usage to a minimum without the overhead of garbage collection. You can even write concurrent code with simple, built-in keywords that define asynchronous behavior, making your code more readable and less error-prone.\n\nDesigned for safety\n\nSwift eliminates entire classes of unsafe code. Variables are always initialized before use, arrays and integers are checked for overflow, memory is automatically managed, and enforcement of exclusive access to memory guards against many programming mistakes. Syntax is tuned to make it easy to define your intent — for example, simple three-character keywords define a variable ( var ) or constant ( let ). And Swift heavily leverages value types, especially for commonly used types like Arrays and Dictionaries. This means that when you make a copy of something with that type, you know it won’t be modified elsewhere.\nAnother safety feature is that by default Swift objects can never be nil. In fact, the Swift compiler will stop you from trying to make or use a nil object with a compile-time error. This makes writing code much cleaner and safer, and prevents a huge category of runtime crashes in your apps. However, there are cases where nil is valid and appropriate. For these situations Swift has an innovative feature known as optionals. An optional may contain nil, but Swift syntax forces you to safely deal with it using the ? syntax to indicate to the compiler you understand the behavior and will handle it safely.\n\nFast and powerful\n\nFrom its earliest conception, Swift was built to be fast. Using the incredibly high-performance LLVM compiler technology, Swift code is transformed into optimized machine code that gets the most out of modern hardware. The syntax and standard library have also been tuned to make the most obvious way to write your code also perform the best whether it runs in the watch on your wrist or across a cluster of servers.\nSwift is a successor to both the C and Objective-C languages. It includes low-level primitives such as types, flow control, and operators. It also provides object-oriented features such as classes, protocols, and generics, giving Cocoa and Cocoa Touch developers the performance and power they demand."
        return view
    }()
    
    var viewContainerBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup(view: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        let keyboardHeight = keyboardViewEndFrame.height - view.safeAreaInsets.bottom
        print(keyboardHeight)
        if notification.name == UIResponder.keyboardWillHideNotification {
            viewContainerBottomConstraint.constant = 0
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        } else {
            viewContainerBottomConstraint.constant = -keyboardHeight
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }

    func viewSetup(view: UIView) {
        view.addSubview(scrollView)
        scrollView.addSubview(viewContainer)
        viewContainer.addSubview(labelTitle)
        viewContainer.addSubview(imageView)
        viewContainer.addSubview(textView)

        viewContainerBottomConstraint = viewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            viewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            viewContainer.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 5),
            viewContainer.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -5),
            viewContainer.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            viewContainerBottomConstraint,
            
            labelTitle.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 10),
            labelTitle.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            
            imageView.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            textView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            textView.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: -5),
            textView.leftAnchor.constraint(equalTo: viewContainer.leftAnchor),
            textView.rightAnchor.constraint(equalTo: viewContainer.rightAnchor),
        ])
    }
}
