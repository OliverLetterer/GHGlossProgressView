# GHGlossProgressView
**GHGlossProgressView** is a progress view for iOS, which comes with a gloss gradient and is based on [Drawing gloss gradients in CoreGraphics](http://cocoawithlove.com/2008/09/drawing-gloss-gradients-in-coregraphics.html).

## How to use GHGlossProgressView

* link against **CoreGraphics.framework**, import the header `#import "GHGlossProgressView.h"` and create an instance

```objective-c 
UIColor *tintColor = ...;
CGFloat progress = ...;
GHGlossProgressView *progressView = [[GHGlossProgressView alloc] initWithFrame:CGRectMake(10.0f, 60.0f * idx + 10.0f, CGRectGetWidth(self.view.bounds) - 20.0f, 50.0f)];
progressView.tintColor = tintColor;
progressView.progress = progress;
```

## Screenshots
<img src="https://github.com/OliverLetterer/GHGlossProgressView/raw/master/Screenshots/1.png">
<img src="https://github.com/OliverLetterer/GHGlossProgressView/raw/master/Screenshots/2.png">
<img src="https://github.com/OliverLetterer/GHGlossProgressView/raw/master/Screenshots/3.png">