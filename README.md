This is an example to demonstrate a mystery about iOS autolayout with table views and self-sizing table view cells.

The example is divided into three parts, represented by the three scenes of the running app. Download and run the app and follow along. You will need to run the app on something like the iPhone SE 2 simulator.

## Scene 1: UILabel

In the first scene, each cell contains a UILabel pinned to all four sides of the content view. We ask for self-sizing cells and we get them. Looks great. Scroll up and down to confirm that all is well.

Now click Next to go on to the second scene.

## Scene 2: StringDrawer

In the second scene, the UILabel has been replaced by a custom view called StringDrawer that draws its own text. It is pinned to all four sides of the content view, just like the label was. We ask for self-sizing cells, but how will we get them?

To solve the problem, I've given StringDrawer an `intrinsicContentSize` based on the string it is displaying. Basically, we measure the string and return the resulting size. In particular, the height will be the minimal height that this view needs to have in order to display the string in full at this view's current width, and the cell is to be sized to that.

But something's wrong. In this scene, some of the initial cells have some extra white space at the bottom. Moreover, if you scroll those cells out of view and then back into view, they look correct. And all the other cells look fine. That proves that what I'm doing is correct, so why isn't it working for the initial cells?

Well, I've done some heavy logging, and I've discovered that at the time `intrinsicContentSize` is called initially for the visible cells, the StringDrawer does not yet correctly know its own final width, the width that it will have after autolayout. We are being called _too soon_. The width we are using is too narrow, so the height we are returning is too tall.

Now click Next to go on to the third scene.

## Scene 3: StringDrawer with workaround

In the third scene, I've added a workaround for the problem we discovered in the second scene. It works great! But it's horribly kludgy. Basically, I wait until the view hierarchy has been assembled, and then I force the table view to do another round of layout by calling `beginUpdates` and `endUpdates`.

----

## The Mystery

Okay, so here are my questions:

**(1)** Is there a better, less kludgy workaround?

**(2)** Why do we need this workaround at all? In particular, why do we have this problem with my StringDrawer but _not_ with a UILabel? Clearly, a UIlabel _does_ know its own width early enough for it to give its own content size correctly on the first pass when it is interrogated by the layout system. Why is my StringDrawer different from that? Why does it need this extra layout pass?
