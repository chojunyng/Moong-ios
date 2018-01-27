//
//  CombineViewController
//  ThinkMemo
//
//  Created by BLU on 2018. 1. 27..
//  Copyright © 2018년 Unithon. All rights reserved.
//

import UIKit

class CombineWordsVC: UIViewController {
    
    @IBOutlet var textView: UITextView! {
        didSet {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 24
            let attributes : [NSAttributedStringKey : Any] = [
                .paragraphStyle : style,
                .font: UIFont(name: "Papya", size:20) ?? UIFont.systemFont(ofSize: 20)
            ]
            textView.attributedText = NSAttributedString(string: textView.text, attributes: attributes)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


