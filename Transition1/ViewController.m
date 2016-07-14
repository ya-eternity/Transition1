//
//  ViewController.m
//  Transition1
//
//  Created by bmxd-002 on 16/7/14.
//  Copyright © 2016年 bmxd-002. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSource = @[@"Boston", @"New York", @"San Francisco", @"Washington"];
    self.view.backgroundColor = [UIColor colorWithRed:0.78 green:0.82 blue:0.84 alpha:1.0];
    self.navigationItem.leftBarButtonItem.image = [self.navigationItem.leftBarButtonItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem.image = [self.navigationItem.rightBarButtonItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self.view addSubview:self.collectionView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (UICollectionView *)collectionView
{
    if (_collectionView) {
        return _collectionView;
    }
    _collectionView = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
        view;
    });
    return _collectionView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
