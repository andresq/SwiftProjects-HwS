import UIKit
//
//let name = "Andres"
//
//for letter in name{
//    print("Give me a \(letter)")
//}
//
//// SLOW
//extension String {
//    subscript(i: Int) -> String {
//        return String(self[index(startIndex, offsetBy: i)])
//    }
//}
//
//// Use to check if a string starts or ends with a substring
//
//let secret = "catbug"
//secret.hasPrefix("cat")
//secret.hasSuffix("bug")
//
//extension String {
//    func deletingPrefix(_ prefix: String) -> String {
//        guard self.hasPrefix(prefix) else {return self}
//        return String(self.dropFirst(prefix.count))
//    }
//
//    func deletingSuffic(_ suffix: String) -> String {
//        guard self.hasSuffix(suffix) else {return self}
//        return String(self.dropLast(suffix.count))
//    }
//}

/**** NSAttributedString ****/

let string = "This is a test String"

//let attributes: [NSAttributedString.Key: Any] = [
//    .foregroundColor: UIColor.white,
//    .backgroundColor: UIColor.green,
//    .font: UIFont.boldSystemFont(ofSize: 36)
//
//]
//// Set in stone
//let attributedString = NSAttributedString(string: string, attributes: attributes)


let attributedString = NSMutableAttributedString(string: string)
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))
