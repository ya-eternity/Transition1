//
//  CollectionViewCell.h
//  Transition1
//
//  Created by bmxd-002 on 16/7/14.
//  Copyright © 2016年 bmxd-002. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UIView *backContainerView;
@property (weak, nonatomic) IBOutlet UIView *frontContainerView;

@property (assign, nonatomic) BOOL isOpen;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *frontViewCenterY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewCenterY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewWidth;

- (void)openAnimated:(BOOL)animated;
- (void)closeAnimated:(BOOL)animated;

@end
