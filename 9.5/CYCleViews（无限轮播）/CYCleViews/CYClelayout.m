//
//  CYClelayout.m
//  CYCleViews
//
//  Created by codygao on 16/9/5.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "CYClelayout.h"

@implementation CYClelayout
-(void)prepareLayout{
    [super prepareLayout];
    self.minimumLineSpacing = 0;
    self.itemSize = self.collectionView.bounds.size;
    self.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    
}
@end
