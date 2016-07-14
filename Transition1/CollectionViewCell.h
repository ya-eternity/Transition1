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
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UIView *backContainerView;
@property (weak, nonatomic) IBOutlet UIView *frontContainerView;

@end
