//
//  ViewController.m
//  Transition1
//
//  Created by bmxd-002 on 16/7/14.
//  Copyright © 2016年 bmxd-002. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "CustomLayout.h"
#import "ColectionModel.h"

static NSString *const CollectionViewCellReuseID = @"CollectionViewCell";

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSource = @[].mutableCopy;
    NSArray *titles = @[@"Boston", @"New York", @"San Francisco", @"Washington", @"Boston", @"New York", @"San Francisco", @"Washington"];
    [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ColectionModel *model = [ColectionModel new];
        model.title = obj;
        [_dataSource addObject:model];
    }];
    self.view.backgroundColor = [UIColor colorWithRed:0.78 green:0.82 blue:0.84 alpha:1.0];
    self.navigationItem.leftBarButtonItem.image = [self.navigationItem.leftBarButtonItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem.image = [self.navigationItem.rightBarButtonItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self.view addSubview:self.collectionView];
        
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(openCell)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(closeCell)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.collectionView addGestureRecognizer:swipeDown];
    
}

- (UICollectionView *)collectionView
{
    if (_collectionView) {
        return _collectionView;
    }
    _collectionView = ({
        CustomLayout *layout = [[CustomLayout alloc] init];
//        layout.
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
        view.backgroundColor = self.view.backgroundColor;
        [view registerNib:[UINib nibWithNibName:CollectionViewCellReuseID bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CollectionViewCellReuseID];
        view.delegate = self;
        view.dataSource = self;
        
        view;
    });
    return _collectionView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - CollectionViewDelegate and Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellReuseID forIndexPath:indexPath];
    
    ColectionModel *model = _dataSource[indexPath.row];
    cell.title.text = model.title;
    cell.isOpen = model.isOpen;
//    NSString *title = _dataSource[indexPath.row];
//    title = [title lowercaseString];
//    NSLog(@"%@", cell.title);
    cell.bgImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"item%ld.png", indexPath.row % 4]];
//    NSLog(@"%@", cell.bgImage);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ColectionModel *model = _dataSource[indexPath.item];
    
}

- (void)openCell
{
    NSLog(@"open cell");
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    NSInteger index = (NSInteger)((self.collectionView.contentOffset.x - layout.minimumLineSpacing)/(layout.itemSize.width));
    CollectionViewCell *cell = (CollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    
    ColectionModel *model = _dataSource[index];
    if (model.isOpen) {
        //跳转下一个页面
        
        return;
    }
    
    model.isOpen = YES;
    [cell openAnimated:YES];
}

- (void)closeCell
{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    NSInteger index = (NSInteger)((self.collectionView.contentOffset.x - layout.minimumLineSpacing)/(layout.itemSize.width));
    CollectionViewCell *cell = (CollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    ColectionModel *model = _dataSource[index];
    if (!model.isOpen) {
        return;
    }
    
    
    
    model.isOpen = NO;
    [cell closeAnimated:YES];
}


@end
