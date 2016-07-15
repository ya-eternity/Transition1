//
//  CustomLayout.m
//  Transition1
//
//  Created by bmxd-002 on 16/7/15.
//  Copyright © 2016年 bmxd-002. All rights reserved.
//

#import "CustomLayout.h"

#define ITEM_SIZE CGSizeMake(256, 335)

@implementation CustomLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.itemSize = ITEM_SIZE;
    float inset = (self.collectionView.bounds.size.width - self.itemSize.width) * 0.25;
    self.minimumLineSpacing = inset;
    self.sectionInset = UIEdgeInsetsMake(0, inset * 2, 0, inset * 2);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;

}

//Bounds发生改变时是否重新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

//吸附效果
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    
//    NSLog(@"proposedOffset%@  velocity%@", NSStringFromCGPoint(proposedContentOffset), NSStringFromCGPoint(velocity));
    //1.计算scrollview最后停留的范围
    CGRect lastRect ;
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.bounds.size;
    CGPoint proposePoint = proposedContentOffset;
    //2.取出这个范围内的所有属性
    NSArray *array = [self layoutAttributesForElementsInRect:lastRect];
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (abs((int)(proposedContentOffset.x - attrs.frame.origin.x)) > lastRect.size.width * 0.5) {
            continue;
        }
        proposePoint.x = attrs.frame.origin.x - self.minimumLineSpacing * 2;
        break;
    }
    
    return proposePoint;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *superAttributes = [super layoutAttributesForElementsInRect:rect];
    NSArray *attributes = [[NSArray alloc] initWithArray:superAttributes copyItems:YES];
    
    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x,
                                    self.collectionView.contentOffset.y,
                                    self.collectionView.frame.size.width,
                                    self.collectionView.frame.size.height);
    CGFloat offset = CGRectGetMidX(visibleRect);
    
    [attributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat distance = offset - attribute.center.x;
        NSLog(@"distance %f", distance);
        // 越往中心移动，值越小，那么缩放就越小，从而显示就越大
        // 同样，超过中心后，越往左、右走，缩放就越大，显示就越小
        CGFloat scaleForDistance = distance / self.itemSize.height;
        // 0.2可调整，值越大，显示就越大
        CGFloat scaleForCell = 1 - 0.2 * (fabs(scaleForDistance));

        attribute.alpha = 1 - fabs(scaleForDistance) * 0.7;
        
        // only scale y-axis
        attribute.transform3D = CATransform3DMakeScale(1, scaleForCell, 1);
        attribute.zIndex = 1;
    }];
    
    return attributes;
}


@end
