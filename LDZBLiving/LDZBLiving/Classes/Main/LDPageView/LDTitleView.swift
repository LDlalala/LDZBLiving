//
//  LDTitleView.swift
//  LDPageView
//
//  Created by 李丹 on 17/8/2.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit

protocol LDTitleViewDelegate : class{
    func titleView(_ titleView : LDTitleView, targetIndex : Int)
}

class LDTitleView: UIView {
    
    weak var delegate : LDTitleViewDelegate?
    fileprivate var titles : [String]
    fileprivate var style : LDPageStyle
    fileprivate var titleLabels : [UILabel] = [UILabel]()
    fileprivate var currentIndex : NSInteger = 0

    // 懒加载scrollView
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollview = UIScrollView(frame: self.bounds)
        scrollview.scrollsToTop = false
        scrollview.bounces = false
        scrollview.showsHorizontalScrollIndicator = false
        return scrollview
    }()
    
    init(titles : [String], frame : CGRect , style: LDPageStyle) {
        self.titles = titles
        self.style = style
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK:- 初始化控件
extension LDTitleView {
    fileprivate func setupUI(){
        // 懒加载scrollview
        addSubview(scrollView)
        
        // 添加标题label
        addTitleLabel()
        
        // 设置标题的frame
        addTitleLabelFrame()
    }
    
    private func addTitleLabel(){
        
        
        for (i,title) in titles.enumerated() {
            let titleLabel = UILabel()
            titleLabel.font = style.font
            titleLabel.textColor = i == 0 ? style.selectColor : style.normalColor
            titleLabel.textAlignment = .center
            titleLabel.text = title
            titleLabel.tag = i
            scrollView.addSubview(titleLabel)
            // 点击手势
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLableClick(_:)))
            titleLabel.addGestureRecognizer(tapGes)
            titleLabel.isUserInteractionEnabled = true
            
            titleLabels.append(titleLabel)

        }
    }
    
    private func addTitleLabelFrame(){
        let count = titles.count
        let y : CGFloat = 0
        var w : CGFloat = 0
        let h : CGFloat = bounds.height
        var x : CGFloat = 0
        
        for (i,titleLabel) in titleLabels.enumerated() {
            if style.isScrollEnadle { // true
                w = (titles[i] as NSString).boundingRect(with:CGSize(width : CGFloat.greatestFiniteMagnitude, height: 0), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : style.font], context: nil).width
                
                if i == 0 {
                    x = style.margin
                }else
                {
                    let preLabel = titleLabels[i - 1]
                    x = preLabel.frame.maxX + style.margin
                }
                
            }else // false
            {
                w = bounds.width / CGFloat(count)
                x = w * CGFloat(i)
                
            }
            titleLabel.frame = CGRect(x: x, y: y, width: w, height: h)
        }
        scrollView.contentSize = CGSize(width: titleLabels[count - 1].frame.maxX + style.margin, height: 0)
    }

}


// MARK:- 点击处理
extension LDTitleView {
    @objc fileprivate func titleLableClick(_ tapGes : UITapGestureRecognizer){

        guard let targetLabel = tapGes.view as? UILabel else { return }
        let currentLabel = titleLabels[currentIndex]
        currentLabel.textColor = style.normalColor
        targetLabel.textColor = style.selectColor
        currentIndex = targetLabel.tag
        
        if style.isScrollEnadle {
            
            // 点击的时候标题居中
            adjustLabelPosition(targetLabel)
        }
        
        // 通知contentView滚动到对应的view上
        delegate?.titleView(self, targetIndex: currentIndex)
    }
    
    // 调整标题位置
    fileprivate func adjustLabelPosition(_ label:UILabel){
        var offsetX = label.center.x - bounds.width * 0.5
        if offsetX < 0{
            offsetX = 0
        }
        
        let maxOffset = scrollView.contentSize.width - bounds.width
        if offsetX > maxOffset {
            offsetX = maxOffset
        }
        scrollView.setContentOffset(CGPoint(x:offsetX,y:0), animated: false)
    }

}

// MARK:- 实现TitleView的代理方法
extension LDTitleView : LDContentViewDelegate{
    func contentView(_ contentView : LDContentView, targetIndex : Int, progress : CGFloat){
        detailTitleLabel(targetIndex: targetIndex, progress: progress)
    }
    
    
    fileprivate func detailTitleLabel(targetIndex : Int,progress : CGFloat){
        let currentLabel = titleLabels[currentIndex]
        let targetLabel = titleLabels[targetIndex]
        currentLabel.textColor = UIColor(r: 255 * progress, g: 255 * progress, b: 255 * progress)
        targetLabel.textColor = style.selectColor
        currentIndex = targetIndex
        
        if style.isScrollEnadle {
            // 点击的时候标题居中
            adjustLabelPosition(targetLabel)
        }
    }
}


// MARK:- 暴露给外界的方法
extension LDTitleView {
    func setTitleLabel(targetIndex : Int,progress : CGFloat){
        detailTitleLabel(targetIndex: targetIndex, progress: progress)
    }
}



