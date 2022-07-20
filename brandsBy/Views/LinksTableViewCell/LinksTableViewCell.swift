//
//  LinksTableViewCell.swift
//  brandsBy
//
//  Created by Alina Karpovich on 11.07.22.
//

import UIKit

class LinksTableViewCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageViewCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}

extension UITextView {
  func addHyperLinksToText(originalText: String, hyperLinks: [String: String]) {
    let style = NSMutableParagraphStyle()
    style.alignment = .left
    let attributedOriginalText = NSMutableAttributedString(string: originalText)
    for (hyperLink, urlString) in hyperLinks {
        let linkRange = attributedOriginalText.mutableString.range(of: hyperLink)
        let fullRange = NSRange(location: 0, length: attributedOriginalText.length)
        attributedOriginalText.addAttribute(NSAttributedString.Key.link, value: urlString, range: linkRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: fullRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue-Thin", size: 15.0) ?? UIFont.boldSystemFont(ofSize: 15.0), range: fullRange)
    }
    self.linkTextAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor.black
    ]
    self.attributedText = attributedOriginalText
  }
}
