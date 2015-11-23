//
//  ratingViewController.swift
//  
//
//  Created by Joshua Xiong on 8/3/15.
//
//

import UIKit

protocol ratingViewControllerDelegate: class {
    func didCompleteRating(state:String, innovation:String)
}

class ratingViewController: UIViewController {
    
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var HardButton: UIButton!
    @IBOutlet weak var SuperButton: UIButton!
    @IBOutlet weak var InnovationButton: UIButton!

    weak var delegate:ratingViewControllerDelegate?

    var workState:String
    var workInnovation:String
    
    var selectedButtonTag:Int
    
    override init(nibName  nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        selectedButtonTag = 1001
        workState = "1"
        workInnovation = "0"
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        let nibNameOrNil:String? = "RatingViewController"
        self.init(nibName: nibNameOrNil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = UIModalPresentationStyle.Custom

    }

    override func viewWillAppear(animated: Bool) {
        selectedButtonTag = switchRadioButton(normalButton, selectedTag: selectedButtonTag, superView: self.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didSelectedRadioButton(sender: UIButton) {
        selectedButtonTag = switchRadioButton(sender, selectedTag: selectedButtonTag, superView: self.view)
        workState = "\(selectedButtonTag - 1000)"
    }
    
    @IBAction func didPressCloseButton(sender: UIButton) {
        closeRatingViewController()
    }
    
    @IBAction func didPressInnovationButton(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected {
            //record the status
            workInnovation = "1"
        }else {
            workInnovation = "0"
        }
    }
    
    @IBAction func didPressSendButton(sender: UIButton) {
        closeRatingViewController()
        self.delegate?.didCompleteRating(workState, innovation: workInnovation)
    }
    
    
    func switchRadioButton(sender:UIButton, selectedTag:Int, superView:UIView) -> Int {
        guard !sender.selected else {
            return selectedTag
        }
        let selectedButton = superView.viewWithTag(selectedTag) as! UIButton
        selectedButton.selected = false
        sender.selected = true
        return sender.tag
    }
    
    func closeRatingViewController() {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
}
