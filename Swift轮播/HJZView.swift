//
//  HJZView.swift
//  Swift轮播
//
//  Created by HuJiazhou on 16/7/16.
//  Copyright © 2016年 HuJiazhou. All rights reserved.
//

import UIKit

class HJZView: UIView ,UIScrollViewDelegate{
    

    let kScreenW = UIScreen.mainScreen().bounds.size.width
    
    var dataArray:NSArray?;
    
    var _scrollView:UIScrollView?;
    
    //计时器
    
    var _timer:NSTimer?;
    
    //主要是为了确定scrollview和pagecontroller的显示位置
    
    var index:Int64?;
    
    var _pageControl:UIPageControl?;
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        /*
          本代码只需要改动dataArray中的图片,
          pageControl,会自动根据数组中的元素个数调整
        
        */
        
        
        dataArray = ["aion01.jpg","aion02.jpg","aion03.jpg","aion04.jpg","aion05.jpg"];
        //
        
        //创建scrollview
        
        _scrollView = UIScrollView(frame: CGRectMake(0, 0, kScreenW,self.bounds.size.height));
        
        _scrollView?.bouncesZoom = false;
        
        _scrollView?.bounces = false;
        
        _scrollView?.showsHorizontalScrollIndicator = false;
        
        _scrollView?.showsVerticalScrollIndicator = false;
        
        _scrollView?.pagingEnabled = true;
        
        _scrollView?.delegate = self;
        
        self.addSubview(_scrollView!);

        _scrollView?.backgroundColor = UIColor.redColor();
        
        //创建pageControl
        
        _pageControl = UIPageControl(frame: CGRectMake(0, self.bounds.size.height - 20, kScreenW, 20));
        
        self.addSubview(_pageControl!);
        
        _pageControl!.backgroundColor = UIColor.clearColor();
        
        _pageControl!.numberOfPages = (dataArray?.count)!;
        
        _pageControl!.currentPage = 0;
        
        _pageControl!.pageIndicatorTintColor = UIColor.whiteColor();
        
        _pageControl!.currentPageIndicatorTintColor = UIColor.orangeColor();
        
        creatImageView();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    //创建scrollview上的图片控件
    
    func creatImageView(){
        
        index = 0;
        
        var i = 0;
        
        
        //创建第一张图片,首个图片框
        
        let firstimage = UIImage(named: dataArray?.lastObject as! String)
        
        let firstimageview = UIImageView(frame: CGRect.init(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        
        firstimageview.image = firstimage
        
        _scrollView?.addSubview(firstimageview)
        
        for imgNmae in dataArray!{
            
            let imgV = UIImageView(frame: CGRectMake(self.bounds.size.width * CGFloat(i+1), 0, self.bounds.size.width, self.bounds.size.height));
            
            imgV.image = UIImage(named: imgNmae as! String);
            
            _scrollView?.addSubview(imgV);
            
            i++ ;
            
        }
        
        //创建最后一个图片框
        
        let lastimage = UIImage(named: dataArray?.firstObject as! String)
        
        let lastimageview = UIImageView(frame: CGRect.init(x: self.bounds.size.width * CGFloat((dataArray?.count)! + 1), y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        
        lastimageview.image = lastimage
        
        _scrollView?.addSubview(lastimageview)
        
        _scrollView?.contentSize = CGSizeMake(self.bounds.size.width * CGFloat((dataArray?.count)! + 2), self.bounds.size.height);
     
        //创建计时器
        
        _timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "timeMethod", userInfo: nil, repeats: true);
        
        //创建runloop设置计时器的运行模式，保证在滑动界面时，计时器也在工作
        
        NSRunLoop.currentRunLoop().addTimer(_timer!, forMode: NSRunLoopCommonModes);
        
    }
    
    //计时器调用的方法
    
    func timeMethod(){
        
        index = index!+1;

        if NSInteger(index!)  == ((dataArray?.count)!) + 1{
            
            index = 0;
            
             _scrollView?.contentOffset = CGPointMake(0, 0)
            
            index = 1;
        }
        
        

       
        UIView.animateWithDuration(0.3) { () -> Void in
            
            self._scrollView!.contentOffset = CGPointMake(CGFloat((self.index!)) * self.kScreenW, self._scrollView!.contentOffset.y);
            
        };
        _pageControl!.currentPage = NSInteger(index!);

        if NSInteger(index!)  == ((dataArray?.count)!) {
            
           _pageControl!.currentPage = 0;
            
        }
       
        

    }
    
    
    // scrollView delegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let x = scrollView.contentOffset.x/kScreenW;
        
        index = Int64(x);
   
        _pageControl!.currentPage = NSInteger(x);
        
    }
    
}
