//
//  TNKAssetsDetailViewController.h
//  Pods
//
//  Created by David Beck on 2/24/15.
//
//

#import <UIKit/UIKit.h>

@class TNKAssetsDetailViewController;
@class PHAssetCollection;
@class PHAsset;


@protocol TNKAssetsDetailViewControllerDelegate <NSObject>

- (BOOL)assetsDetailViewController:(TNKAssetsDetailViewController *)viewController isAssetSelectedAtIndexPath:(NSIndexPath *)indexPath;

- (void)assetsDetailViewController:(TNKAssetsDetailViewController *)viewController selectAssetAtIndexPath:(NSIndexPath *)indexPath;
- (void)assetsDetailViewController:(TNKAssetsDetailViewController *)viewController deselectAssetAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface TNKAssetsDetailViewController : UIPageViewController

@property (nonatomic, weak) id<TNKAssetsDetailViewControllerDelegate> assetDelegate;

/** The asset collection the picker will display to the user.
 
 nil (the default) will cause the picker to display the user's moments.
 */
@property (nonatomic, strong) PHAssetCollection *assetCollection;

- (void)showAssetAtIndexPath:(NSIndexPath *)indexPath;

@end