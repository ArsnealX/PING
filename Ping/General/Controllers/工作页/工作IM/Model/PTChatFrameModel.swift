//
//  PTChatFrameModel.swift
//  Ping
//
//  Created by zhizhong.zhou on 16/5/14.
//  Copyright © 2016年 Kejukeji. All rights reserved.
//

import UIKit

class PTChatFrameModel: NSObject {

    var noticeLabelFrame:CGRect = CGRectZero
    
    var titleLabelFrame:CGRect = CGRectZero

    var contentBtnFrame:CGRect = CGRectZero
    
    var iconImageViewFrame:CGRect = CGRectZero
    
    /**
     *  行高
     */
    var cellHeight:CGFloat = 0
    var chatModel:PTChatModel?{
        
        didSet {
             self.titleLabelFrame = CGRect(x: 0,y: 0,width: PTScreenWidth, height: chatModel!.hiddenTime ? 0 : 30)
            //间距
            let margin:CGFloat = 10
            //头像大小
            let iconWH:CGFloat = 50
            //通知
            let number:NSNumber = 2
            
            if ((chatModel?.type.isEqualToNumber(number)) == true) {
                let noticeSize = self.sizeWithText((chatModel?.text)!)
                self.noticeLabelFrame = CGRect(x: (PTScreenWidth - noticeSize.width-20)/2,
                                               y: 0,
                                               width: noticeSize.width+15,
                                               height: noticeSize.height+10)
                self.cellHeight = noticeSize.height + 20
                
            } else {
                let contentSize = self.sizeWithText((chatModel?.text)!)
                let contentBtnWidth = contentSize.width + 40
                let kContentBtnHeight = contentSize.height + 35
                //头像大小 50 * 50
                let number:NSNumber = 0
                 if ((chatModel?.type.isEqualToNumber(number)) == true) {
                     self.iconImageViewFrame = CGRect(x: (PTScreenWidth - iconWH - margin),
                                               y: 0,
                                               width: iconWH,
                                               height: iconWH)
                    self.contentBtnFrame = CGRect(x: (CGRectGetMinX(self.iconImageViewFrame) - margin - contentBtnWidth),
                                                     y: 0,
                                                     width: contentBtnWidth,
                                                     height: kContentBtnHeight)
                 } else {
                    self.iconImageViewFrame = CGRect(x: margin,
                                                     y: 0,
                                                     width: iconWH,
                                                     height: iconWH)
                    self.contentBtnFrame = CGRect(x: (margin + iconWH + margin),
                                                  y: 0,
                                                  width: contentBtnWidth,
                                                  height: kContentBtnHeight)

                }
                self.cellHeight = max(CGRectGetMaxY(self.contentBtnFrame), CGRectGetMaxY(self.titleLabelFrame)) + margin

            }
        }
      
    }
//    _contentBtnFrame = CGRectMake(kWidth - kContentBtnWidth - iconWH - margin - margin,
//    CGRectGetMaxY(_titleLabelFrame),
//    kContentBtnWidth,
//    kContentBtnHeight);
//    }else {
//    _iconImageViewFrame = CGRectMake(margin, CGRectGetMaxY(_titleLabelFrame), iconWH, iconWH);
//
//    _contentBtnFrame = CGRectMake(margin + iconWH + margin,
//    CGRectGetMaxY(_titleLabelFrame),
//    kContentBtnWidth,
//    kContentBtnHeight);
//    }
//    _cellHeight = MAX(CGRectGetMaxY(_contentBtnFrame), CGRectGetMaxY(_titleLabelFrame)) + margin;
//    
//    }


    private func sizeWithText(text:NSString)->CGSize{
        let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(15)]
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        let size = CGSize.init(width: PTScreenWidth - 150, height: 10000.00)
        let rect:CGRect = text.boundingRectWithSize(size, options: option, attributes: attributes, context: nil)
        return rect.size
    }
    
    
}
