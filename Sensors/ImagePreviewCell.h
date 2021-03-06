//
//  ImagePreviewCell.h
//  Sensors
//
//  Created by John Jusayan on 2/10/14.
//  Copyright (c) 2014 Treeness, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePreviewCell : UICollectionViewCell

/**Image View that displays the photo
 */
@property (nonatomic, weak) IBOutlet UIImageView *imageView;

/**Label that displays the date
 */
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
