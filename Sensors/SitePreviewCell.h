//
//  SitePreviewCell.h
//  Sensors
//
//  Created by John Jusayan on 12/2/13.
//  Copyright (c) 2013 CSE UNR All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SitePreviewCell : UICollectionViewCell

/**Image View that displays the photo
 */
@property (nonatomic, weak) IBOutlet UIImageView *imageView;

/**Label that displays the site name
 */
@property (weak, nonatomic) IBOutlet UILabel *siteNameLabel;

/**Label that displays the date
 */
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
