//
//  DynamicCollectionViewFlowLayout.swift
//  Dummy Messager
//
//  Created by Sanford Wilson on 8/8/17.
//  Copyright © 2017 Sanford Wilson. All rights reserved.
//

import UIKit

class DynamicCollectionViewFlowLayout: UICollectionViewFlowLayout {

    var dynamicAnimator: UIDynamicAnimator!

    override init() {
        super.init()
        self.dynamicAnimator = UIDynamicAnimator(collectionViewLayout: self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return dynamicAnimator.items(in: rect) as? [UICollectionViewLayoutAttributes]
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return dynamicAnimator.layoutAttributesForCell(at: indexPath) ?? super.layoutAttributesForItem(at: indexPath)
    }

    override func prepare() {
        super.prepare()
        var items = [UICollectionViewLayoutAttributes]()
        if let contentSize = self.collectionView?.contentSize {
            items = super.layoutAttributesForElements(in:
              CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height))!
        }
        if dynamicAnimator.behaviors.count == 0 {
            for item in items {
                let behavior = UIAttachmentBehavior(item: item, attachedToAnchor: item.center)

                behavior.length = 0.0
                behavior.damping = 0.8
                behavior.frequency = 1.0
                dynamicAnimator.addBehavior(behavior)
            }
        }
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        let delta = newBounds.origin.y - (collectionView?.bounds.origin.y)!

        let touchPoint = collectionView?.panGestureRecognizer.location(in: collectionView)

        for behavior in dynamicAnimator.behaviors {
            let useBehavior = behavior as? UIAttachmentBehavior
            let touchDistanceY = fabs((touchPoint?.y)! - (useBehavior?.anchorPoint.y)!)
            let resistance = touchDistanceY/1500.0

            let item = useBehavior?.items.first
            var center = item?.center
            if delta < 0 {
                center?.y += max(delta, delta * resistance)
            } else {
                center?.y += min(delta, delta * resistance)
            }
            item?.center = center!
            dynamicAnimator.updateItem(usingCurrentState: item!)
        }
        return false
    }

    func reset() {
        dynamicAnimator.removeAllBehaviors()
        prepare()
    }
}
