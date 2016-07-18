//
//  CollectionViewCell.m
//  Transition1
//
//  Created by bmxd-002 on 16/7/14.
//  Copyright © 2016年 bmxd-002. All rights reserved.
//

#import "CollectionViewCell.h"

static const CGFloat moveDistance = 60;


@interface CollectionViewCell ()

@property (strong, nonatomic) CADisplayLink *displayLink;
@end

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.clipsToBounds = NO;
    
    _shadowView.layer.shadowRadius = 20;
    _shadowView.layer.shadowColor = [UIColor grayColor].CGColor;
    _shadowView.layer.shadowOffset = CGSizeMake(3, 4);
    _shadowView.layer.shadowOpacity = 1;
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateMoveDistance)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    _displayLink.paused = YES;
}

static CGFloat moved = 0;

- (void)updateMoveDistance
{
    if (moved < moveDistance) {
        moved += 2;
        if (_isOpen) {
            [self viewsMoveDistance:-2];
        } else {
            [self viewsMoveDistance:2];
        }
    } else {
        moved = 0;
        _isOpen = !_isOpen;
        _displayLink.paused = YES;;
    }
    
}

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self = [[[NSBundle mainBundle] loadNibNamed:@"CollectionViewCell" owner:nil options:nil] lastObject]; 
//    }
//    return self;
//}

- (void)setIsOpen:(BOOL)isOpen
{
    if (isOpen && _backContainerView.frame.size.width ==  _frontContainerView.frame.size.width) {
        [self openAnimated:NO];
    } else if (!isOpen && _backContainerView.frame.size.width !=  _frontContainerView.frame.size.width){
        [self closeAnimated:NO];
    }
    _isOpen = isOpen;
}



- (void)openAnimated:(BOOL)animated
{
//    if (_isOpen) {
//        return;
//    }
//    _isOpen = YES;
//    __weak typeof(self) ws = self;
    if (animated) {
        
        _displayLink.paused = NO;

        return;
    }
    [self viewsMoveDistance:moveDistance];
}

- (void)closeAnimated:(BOOL)animated
{
//    if (!_isOpen) {
//        return;
//    }
//    _isOpen = NO;
//    __weak typeof(self) ws = self;
    if (animated) {
        _displayLink.paused = NO;
        return ;
    }
    [self viewsMoveDistance:-moveDistance];
}

- (void)viewsMoveDistance:(CGFloat)distance
{
    _backViewCenterY.constant += distance;
    _frontViewCenterY.constant -= distance;
    _backViewWidth.constant += distance;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

@end
