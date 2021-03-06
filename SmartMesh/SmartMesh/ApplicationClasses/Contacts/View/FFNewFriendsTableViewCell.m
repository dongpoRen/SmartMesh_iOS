//
//  FFNewFriendsTableViewCell.m
//  NextApp
//
//  Created by Megan on  17-12-12.
//  Copyright (c) 2017年 SmartMesh Foundation All rights reserved.
//

#import "FFNewFriendsTableViewCell.h"

@interface FFNewFriendsTableViewCell ()
{
    UIImageView *_avatarView;
    UILabel     *_nameLabel;
    UILabel     *_applyLabel;
    UIButton    *_addBtn;
    UILabel     *_addedLbl;
    UIView      *_line;
}
@end

@implementation FFNewFriendsTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *cellID = NSStringFromClass([self class]);
    FFNewFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    return cell?cell:[[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupContentView];
    }
    return self;
}

- (void)setupContentView
{
    _avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    _avatarView.image = [UIImage imageNamed:@"icon_head_defaul"];
    _avatarView.backgroundColor = LC_RGB(200,200, 200);
    _avatarView.layer.cornerRadius = 25;
    _avatarView.layer.masksToBounds = YES;
    [self.contentView addSubview:_avatarView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:LC_RECT(_avatarView.viewRightX + 10, 0,DDYSCREENW - 150 , 35)];
    _nameLabel.textColor = DDY_Big_Black;
    _nameLabel.font = NA_FONT(17);
    _nameLabel.text = @"Megan";
    [self.contentView addSubview:_nameLabel];
    
    _applyLabel = [[UILabel alloc] initWithFrame:LC_RECT(_avatarView.viewRightX + 10, 35,DDYSCREENW - 150 , 35)];
    _applyLabel.textColor = LC_RGB(170, 170, 170);
    _applyLabel.font = NA_FONT(15);
    _applyLabel.text = @"username";
    [self.contentView addSubview:_applyLabel];
    
    _addBtn = [[UIButton alloc] initWithFrame:LC_RECT(DDYSCREENW - 70, 20, 50, 30)];
    _addBtn.titleLabel.font = NA_FONT(15);
    [_addBtn setTitle:@"ADD" forState:UIControlStateNormal];
    [_addBtn setTitleColor:APP_MAIN_COLOR forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_addBtn];
    _addBtn.layer.cornerRadius = 5;
    _addBtn.layer.masksToBounds = YES;
    _addBtn.layer.borderWidth = 1;
    _addBtn.layer.borderColor = APP_MAIN_COLOR.CGColor;
    _addBtn.hidden = YES;
    
    _addedLbl = [[UILabel alloc] init];
    _addedLbl.textAlignment = NSTextAlignmentCenter;
    _addedLbl.hidden = YES;
    _addedLbl.text = @"Added";
    _addedLbl.frame = CGRectMake(DDYSCREENW - 70, 20, 50, 30);
    _addedLbl.font = NA_FONT(15);
    _addedLbl.textColor = [UIColor blackColor];
    [self.contentView addSubview:_addedLbl];
    
    _line = [[UIView alloc] initWithFrame:LC_RECT(10, 69, DDYSCREENH - 10, 1)];
    _line.backgroundColor = LC_RGB(235, 235, 235);
    [self.contentView addSubview:_line];
    
}

-(void)addAction
{
    if (self.addFriendBlock) {
        self.addFriendBlock(_message);
    }
}

- (void)setMessage:(FFMessage *)message
{
    _message = message;
    
    if (self.userListType == FFAddUserListType) {
        
        //        _avatarView.image = requestItem.userImage;
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:message.userImage]];
        _avatarView.image = [UIImage imageWithData:data];
        _nameLabel.text = message.nickName;
        _applyLabel.text = message.textContent;
        if ([message.accepted isEqualToString:@"1"]) { // 已经为好友
            _addBtn.hidden = YES;
            _addedLbl.hidden = NO;
        }else {
            _addBtn.hidden = NO;
            _addedLbl.hidden = YES;
        }
    }
}

//- (void)setRequestItem:(FFContactsRequestItem *)requestItem
//{
//    _requestItem = requestItem;
//
//    if (self.userListType == FFAddUserListType) {
//
//        //        _avatarView.image = requestItem.userImage;
//
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:requestItem.userImage]];
//        _avatarView.image = [UIImage imageWithData:data];
//        _nameLabel.text = requestItem.nickName;
//        _applyLabel.text = requestItem.textContent;
//        if ([requestItem.accepted isEqualToString:@"1"]) { // 已经为好友
//            _addBtn.hidden = YES;
//            _addedLbl.hidden = NO;
//        }else {
//            _addBtn.hidden = NO;
//            _addedLbl.hidden = YES;
//        }
//    }
//
//}

-(void)setUser:(FFUser *)user
{
    if (self.userListType == FFUserListDiscoverType) {
        
        _addBtn.hidden = YES;
    }
    else if (self.userListType == FFAddUserListType)
    {
        _addBtn.hidden = NO;
    }

    _nameLabel.text = user.remarkName;

    [_avatarView sd_setImageWithURL:[NSURL URLWithString:user.userImage] placeholderImage:[UIImage imageNamed:@"icon_head_defaul"]];
}

@end
