//
//  PTChatCell.swift
//  Ping
//
//  Created by zhizhong.zhou on 16/5/14.
//  Copyright © 2016年 Kejukeji. All rights reserved.
//

import UIKit

class PTChatCell: UITableViewCell {
    
    var frameModel:PTChatFrameModel? {
        didSet {
            self.setSubviewsData()
            self.setSubviewsFrame()
        }
    }
    var noticeLabel:UILabel?
    var titleLabel:UILabel?
    var contentBtn:UIButton?
    var iconImageView:UIImageView?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None;
        
        let noticeLabel:UILabel = UILabel()
        noticeLabel.textAlignment = NSTextAlignment.Center
        noticeLabel.font = UIFont.systemFontOfSize(15)
        noticeLabel.numberOfLines = 0
        noticeLabel.textColor = UIColor.whiteColor()
        noticeLabel.backgroundColor = UIColor.colorWithRGB(181.0, green: 181.0, blue: 181.0)
        self.contentView.addSubview(noticeLabel);
        self.noticeLabel = noticeLabel
        
        let titleLabel:UILabel = UILabel()
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.font = UIFont.systemFontOfSize(15)
        titleLabel.clipsToBounds = true
        self.contentView.addSubview(titleLabel);
        self.titleLabel = titleLabel
        
        let iconImageView = UIImageView()
        iconImageView.layer.cornerRadius = 25
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.borderWidth = 1.0
        self.contentView.addSubview(iconImageView)
        self.iconImageView = iconImageView;
        
        let contentBtn = UIButton(type: UIButtonType.Custom)
        self.contentView.addSubview(contentBtn)
        self.contentBtn = contentBtn
        let  btnBackImage = UIImage.init(named: "chat_send_nor")
        let w:NSInteger = Int( (btnBackImage?.size.width)! / 2)
        
        let h:NSInteger = Int( (btnBackImage?.size.height)! / 2)
        
        contentBtn.setBackgroundImage(btnBackImage?.stretchableImageWithLeftCapWidth(w, topCapHeight: h), forState: UIControlState.Normal)
        contentBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        contentBtn.titleLabel?.numberOfLines = 0
        contentBtn.titleLabel!.font = UIFont.systemFontOfSize(15)
        contentBtn.titleEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    private func setSubviewsData()->Void {
        let number:NSNumber = 2
        if ((self.frameModel!.chatModel!.type.isEqualToNumber(number)) == true) {
            self.noticeLabel!.text = self.frameModel!.chatModel!.text
            self.noticeLabel!.hidden = false
            self.titleLabel!.hidden = true
            self.contentBtn!.hidden = true
            self.iconImageView!.hidden = true
        } else {
            self.noticeLabel!.hidden = true
            self.titleLabel!.hidden = false
            self.contentBtn!.hidden = false
            self.iconImageView!.hidden = false
            let  str:String = self.frameModel!.chatModel!.time
            let dateStrflag =  str.characters.count == 14
            if (dateStrflag) {
                let ns1=(str as NSString).substringWithRange(NSMakeRange(8, 2))
                let ns2=(str as NSString).substringWithRange(NSMakeRange(10, 2))
                let string = ns1+ns2
                self.titleLabel!.text = string
            } else {
                self.titleLabel!.text = self.frameModel!.chatModel!.time;
            }
            self.contentBtn?.setTitle(self.frameModel?.chatModel?.text, forState: UIControlState.Normal)
            let number:NSNumber = 0
            if ((self.frameModel!.chatModel!.type.isEqualToNumber(number)) == true) {
                let  btnBackImage = UIImage.init(named: "me")
                self.iconImageView!.image = btnBackImage
                let  chatImag = UIImage.init(named: "chat_send_nor")
                let w:NSInteger = Int( (chatImag?.size.width)! / 2)
                
                let h:NSInteger = Int( (chatImag?.size.height)! / 2)
                
                self.contentBtn?.setBackgroundImage(chatImag?.stretchableImageWithLeftCapWidth(w, topCapHeight: h), forState: UIControlState.Normal)
                let  btnBackImageHelight = UIImage.init(named: "chat_send_press_pic")
                let w1:NSInteger = Int( (btnBackImageHelight?.size.width)! / 2)
                 let h1:NSInteger = Int( (btnBackImageHelight?.size.height)! / 2)
                 self.contentBtn?.setBackgroundImage(chatImag?.stretchableImageWithLeftCapWidth(w1, topCapHeight: h1 ), forState: UIControlState.Normal)

            } else {
                let  btnBackImage = UIImage.init(named: "other")
                self.iconImageView!.image = btnBackImage
                let  chatImag = UIImage.init(named: "chat_recive_nor")
                let w:NSInteger = Int( (chatImag?.size.width)! / 2)
                
                let h:NSInteger = Int( (chatImag?.size.height)! / 2)
                
                self.contentBtn?.setBackgroundImage(chatImag?.stretchableImageWithLeftCapWidth(w, topCapHeight: h), forState: UIControlState.Normal)
                let  btnBackImageHelight = UIImage.init(named: "chat_recive_press_pic")
                let w1:NSInteger = Int( (btnBackImageHelight?.size.width)! / 2)
                let h1:NSInteger = Int( (btnBackImageHelight?.size.height)! / 2)
                self.contentBtn?.setBackgroundImage(btnBackImageHelight?.stretchableImageWithLeftCapWidth(w1, topCapHeight: h1 ), forState: UIControlState.Normal)
            }
        }
    }
    
     private func setSubviewsFrame()->Void {
        self.noticeLabel!.frame = self.frameModel!.noticeLabelFrame;
        self.titleLabel!.frame = self.frameModel!.titleLabelFrame;
        self.contentBtn!.frame = self.frameModel!.contentBtnFrame;
        self.iconImageView!.frame = self.frameModel!.iconImageViewFrame;
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
