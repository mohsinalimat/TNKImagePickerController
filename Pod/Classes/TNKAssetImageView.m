//
//  TNKAssetImageView.m
//  Pods
//
//  Created by David Beck on 2/19/15.
//
//

#import "TNKAssetImageView.h"

#import "TNKImagePickerControllerBundle.h"


@interface TNKAssetImageView ()
{
    BOOL _needsAssetReload;
}

@end

@implementation TNKAssetImageView

- (void)setAsset:(PHAsset *)asset
{
    if (_asset != asset) {
        [self cancelAssetImageRequest];
        
        _asset = asset;
        self.image = self.defaultImage;
        
        [self setNeedsAssetReload];
    }
}

- (void)setNeedsAssetReload
{
    if (!_needsAssetReload) {
        _needsAssetReload = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadAssetImage];
        });
    }
}

- (void)loadAssetImage
{
    [self cancelAssetImageRequest];
    
    if (_asset != nil && self.bounds.size.width > 0.0 && self.bounds.size.height > 0.0) {
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        options.resizeMode = PHImageRequestOptionsResizeModeExact;
        
        CGSize size = self.bounds.size;
        size.width *= self.traitCollection.displayScale;
        size.height *= self.traitCollection.displayScale;
        
        self.imageRequestID = [[PHImageManager defaultManager] requestImageForAsset:_asset targetSize:size contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage *result, NSDictionary *info) {
            self.image = result;
        }];
    }
    
    _needsAssetReload = NO;
}

- (void)cancelAssetImageRequest
{
    if (self.imageRequestID != 0) {
        [[PHImageManager defaultManager] cancelImageRequest:self.imageRequestID];
        self.imageRequestID = 0;
    }
}

- (void)setFrame:(CGRect)frame
{
    BOOL changed = !CGSizeEqualToSize(self.frame.size, frame.size);
    
    [super setFrame:frame];
    
    if (changed) {
        [self setNeedsAssetReload];
    }
}

- (void)setBounds:(CGRect)bounds
{
    BOOL changed = !CGSizeEqualToSize(self.bounds.size, bounds.size);
    
    [super setBounds:bounds];
    
    if (changed) {
        [self setNeedsAssetReload];
    }
}

@end
