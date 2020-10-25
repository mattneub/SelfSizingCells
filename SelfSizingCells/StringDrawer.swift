

import UIKit

class StringDrawer: UIView {
    @NSCopying var attributedText = NSAttributedString() {
        didSet {
            self.setNeedsDisplay()
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override func draw(_ rect: CGRect) {
        self.attributedText.draw(with: rect, options: [.truncatesLastVisibleLine, .usesLineFragmentOrigin], context: nil)
    }
    
    override var intrinsicContentSize: CGSize {
        let measuredSize = self.attributedText.boundingRect(
            with: CGSize(width:self.bounds.width, height:10000),
            options: [.truncatesLastVisibleLine, .usesLineFragmentOrigin],
            context: nil).size
        return CGSize(width: UIView.noIntrinsicMetric, height: measuredSize.height.rounded(.up) + 1)
    }

}
