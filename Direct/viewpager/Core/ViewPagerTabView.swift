//
//  ViewPagerTabView.swift
//  ViewPager-Swift
//
//  Created by Nishan on 1/9/17.
//  Copyright © 2017 Nishan. All rights reserved.
//

import UIKit
enum TabContentDirection {
    case vertical, horizontal
}

public final class ViewPagerTabView: UIView {
    var tabContentDirection: TabContentDirection = .horizontal
    internal var titleLabel: UILabel?
    internal var imageView: UIImageView?
    /*--------------------------
     MARK: - Initialization
     ---------------------------*/
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*--------------------------
     MARK: - Tab Setup
     ---------------------------*/
    
    /**
     Sets up tabview for ViewPager. The type of tabview is automatically obtained from
     the options passed in this function.
     */
    internal func setup(tab: ViewPagerTab, options: ViewPagerOptions) {
        switch options.tabType {
        case ViewPagerTabType.basic:
            setupBasicTab(options: options, tab: tab)
            
        case ViewPagerTabType.image:
            setupImageTab(withText: false, options: options, tab: tab)
            
        case ViewPagerTabType.imageWithText:
            setupImageTab(withText: true, options: options, tab: tab)
        }
    }
    
    /**
     * Creates tab containing only one label with provided options and add it as subview to this view.
     *
     * Case FitAllTabs: Creates a tabview of provided width. Does not consider the padding provided from ViewPagerOptions.
     *
     * Case DistributeNormally: Creates a tabview. Width is calculated from title intrinsic size. Considers the padding
     * provided from options too.
     */
    fileprivate func setupBasicTab(options: ViewPagerOptions, tab: ViewPagerTab) {
        buildTitleLabel(withOptions: options, text: tab.title)
        
        setupForAutolayout(view: titleLabel)
        titleLabel?.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel?.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleLabel?.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        let distribution = options.distribution
        
        guard distribution == .equal || distribution == .normal else { return }
        
        let labelWidth = titleLabel!.intrinsicContentSize.width + options.tabViewPaddingLeft + options.tabViewPaddingRight
        width = labelWidth
    }
    
    /**
     * Creates tab containing image or image with text. And adds it as subview to this view.
     *
     * Case FitAllTabs: Creates a tabview of provided width. Doesnot consider padding provided from ViewPagerOptions.
     * ImageView is centered inside tabview if tab type is Image only. Else image margin are used to calculate the position
     * in case of tab type ImageWithText.
     *
     * Case DistributeNormally: Creates a tabView. Width is automatically calculated either from imagesize or text whichever
     * is larger. ImageView is centered inside tabview with provided paddings if tab type is Image only. Considers both padding
     * and image margin incase tab type is ImageWithText.
     */
    fileprivate func setupImageTab(withText: Bool, options: ViewPagerOptions, tab: ViewPagerTab) {
        let distribution = options.distribution
        
        let imageSize = options.tabViewImageSize
        
        switch distribution {
        case .segmented:
            
            if withText {
                buildImageView(withOptions: options, image: tab.image)
                buildTitleLabel(withOptions: options, text: tab.title)
                
                setupForAutolayout(view: imageView)
                if tabContentDirection == .vertical {
                    imageView?.heightAnchor.constraint(equalToConstant: imageSize.height).isActive = true
                    imageView?.widthAnchor.constraint(equalToConstant: imageSize.width).isActive = true
                    imageView?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
                    imageView?.topAnchor.constraint(equalTo: topAnchor, constant: options.tabViewImageMarginTop).isActive = true
                    
                    setupForAutolayout(view: titleLabel)
                    titleLabel?.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
                    titleLabel?.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
                    titleLabel?.topAnchor.constraint(equalTo: imageView!.bottomAnchor, constant: options.tabViewImageMarginBottom).isActive = true
                    titleLabel?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
                } else {
                    imageView?.leadingAnchor.constraint(equalTo: leadingAnchor, constant: options.tabViewImageMarginTop).isActive = true
                    imageView?.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
                    imageView?.heightAnchor.constraint(equalToConstant: imageSize.height).isActive = true
                    imageView?.widthAnchor.constraint(equalToConstant: imageSize.width).isActive = true
                    
                    setupForAutolayout(view: titleLabel)
                    titleLabel?.leadingAnchor.constraint(equalTo: imageView!.trailingAnchor).isActive = true
                    titleLabel?.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
                    titleLabel?.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
                }
            } else {
                buildImageView(withOptions: options, image: tab.image)
                
                setupForAutolayout(view: imageView)
                imageView?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
                imageView?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
                imageView?.widthAnchor.constraint(equalToConstant: imageSize.width).isActive = true
                imageView?.heightAnchor.constraint(equalToConstant: imageSize.height).isActive = true
            }
            
        case .normal, .equal:
            
            if withText {
                buildImageView(withOptions: options, image: tab.image)
                buildTitleLabel(withOptions: options, text: tab.title)
                
                setupForAutolayout(view: imageView)
                if tabContentDirection == .vertical {
                    imageView?.heightAnchor.constraint(equalToConstant: imageSize.height).isActive = true
                    imageView?.widthAnchor.constraint(equalToConstant: imageSize.width).isActive = true
                    imageView?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
                    imageView?.topAnchor.constraint(equalTo: topAnchor, constant: options.tabViewImageMarginTop).isActive = true
                    
                    setupForAutolayout(view: titleLabel)
                    titleLabel?.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
                    titleLabel?.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
                    titleLabel?.topAnchor.constraint(equalTo: imageView!.bottomAnchor, constant: options.tabViewImageMarginBottom).isActive = true
                    titleLabel?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
                    let widthFromImage = imageSize.width + options.tabViewPaddingRight + options.tabViewPaddingLeft
                    let widthFromText = titleLabel!.intrinsicContentSize.width + options.tabViewPaddingLeft + options.tabViewPaddingRight
                    let tabWidth = max(widthFromImage, widthFromText)
                    width = tabWidth
                } else if tabContentDirection == .horizontal {
                    imageView?.leadingAnchor.constraint(equalTo: leadingAnchor, constant: options.tabViewImageMarginTop).isActive = true
                    imageView?.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
                    imageView?.heightAnchor.constraint(equalToConstant: imageSize.height).isActive = true
                    imageView?.widthAnchor.constraint(equalToConstant: imageSize.width).isActive = true
                    
                    setupForAutolayout(view: titleLabel)
                    titleLabel?.leadingAnchor.constraint(equalTo: imageView!.trailingAnchor).isActive = true
                    titleLabel?.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
                    titleLabel?.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
                    // Resetting tabview frame again with the new width
                    let widthFromImage = imageSize.width + options.tabViewPaddingRight + options.tabViewPaddingLeft
                    let widthFromText = titleLabel!.intrinsicContentSize.width + options.tabViewPaddingLeft + options.tabViewPaddingRight
                    let tabWidth = widthFromImage + widthFromText
                    width = tabWidth
                }
            } else {
                // Creating imageview
                buildImageView(withOptions: options, image: tab.image)
                
                setupForAutolayout(view: imageView)
                imageView?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
                imageView?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
                imageView?.widthAnchor.constraint(equalToConstant: imageSize.width).isActive = true
                imageView?.heightAnchor.constraint(equalToConstant: imageSize.height).isActive = true
                
                // Determining the max width this tab should use
                let tabWidth = imageSize.width + options.tabViewPaddingRight + options.tabViewPaddingLeft
                width = tabWidth
            }
        }
    }
    
    /*--------------------------
     MARK: - Helper Methods
     ---------------------------*/
    
    fileprivate func buildTitleLabel(withOptions options: ViewPagerOptions, text: String) {
        titleLabel = UILabel()
        titleLabel?.textAlignment = .center
        titleLabel?.textColor = options.tabViewTextDefaultColor
        titleLabel?.numberOfLines = 2
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.font = options.tabViewTextFont
        titleLabel?.text = text
    }
    
    fileprivate func buildImageView(withOptions options: ViewPagerOptions, image: UIImage?) {
        imageView = UIImageView()
        imageView?.contentMode = .scaleAspectFit
        imageView?.image = image
    }
    
    internal func addHighlight(options: ViewPagerOptions) {
        backgroundColor = options.tabViewBackgroundHighlightColor
        titleLabel?.textColor = options.tabViewTextHighlightColor
    }
    
    internal func removeHighlight(options: ViewPagerOptions) {
        backgroundColor = options.tabViewBackgroundDefaultColor
        titleLabel?.textColor = options.tabViewTextDefaultColor
    }
    
    internal func setupForAutolayout(view: UIView?) {
        guard let v = view else { return }
        
        v.translatesAutoresizingMaskIntoConstraints = false
        addSubview(v)
    }
}
