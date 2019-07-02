//
//  TweetCell.h
//  twitter
//
//  Created by andrews9 on 7/2/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

@property (strong, nonatomic) NSString *tweet;
@property (weak, nonatomic) IBOutlet UIImageView *AVIView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;

@end

NS_ASSUME_NONNULL_END
