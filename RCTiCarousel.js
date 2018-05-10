'use strict';

import PropTypes from 'prop-types';
import React, { Component } from 'react';
import {
    requireNativeComponent,
    NativeModules,
    findNodeHandle
 } from 'react-native';

var RNiCarousel = requireNativeComponent('RCTiCarousel', RCTiCarousel);
var RNiCarouselManager = NativeModules.iCarouselManager;
var RNiCarouselType = RNiCarouselManager.Type;

/**
 * RCTiCarousel
 */
export default class RCTiCarousel extends React.Component {
    static propTypes = {
        items: PropTypes.array,
        type: PropTypes.number,
        bounces: PropTypes.bool,
        optionValueConfigurations: PropTypes.object,

        onDidSelectItemAtIndex: PropTypes.func,
        onCurrentItemIndexDidChange: PropTypes.func
    }

    scrollByOffsetDuration(offset, duration) {
        RNiCarouselManager.shouldScrollByOffsetDuration(
            findNodeHandle(this), 
            offset, 
            duration
        );
    }

    scrollToOffsetDuration(offset, duration) {
        RNiCarouselManager.shouldScrollToOffsetDuration(
            findNodeHandle(this), 
            offset, 
            duration
        );
    }

    scrollByNumberOfItemsDuration(itemCount, duration) {
        RNiCarouselManager.shouldScrollByNumberOfItemsDuration(
            findNodeHandle(this), 
            itemCount, 
            duration
        );
    }

    scrollToItemAtIndexDuration(index, duration) {
        RNiCarouselManager.shouldScrollToItemAtIndexDuration(
            findNodeHandle(this), 
            index, 
            duration
        );
    }

    scrollToItemAtIndexAnimated(index, animated) {
        RNiCarouselManager.shuoldScrollToItemAtIndexAnimated(
            findNodeHandle(this), 
            index, 
            animated
        );
    }

    itemViewAtIndexHandler(index, resolve, reject) {
        RNiCarouselManager.fetchItemViewAtIndexHandler(
            findNodeHandle(this), 
            index,
            resolve,
            reject
        );
    }

    indexOfItemViewCallback(view, callback) {
        RNiCarouselManager.fetchIndexOfItemViewCallback(
            findNodeHandle(this), 
            view, 
            callback
        );
    }

    indexOfItemViewOrSubviewCallback(view, callback) {
        RNiCarouselManager.fetchIndexOfItemViewOrSubviewCallback(
            findNodeHandle(this), 
            view, 
            callback
        );
    }

    offsetForItemAtIndexCallback(index, callbakc) {
        RNiCarouselManager.fetchOffsetForItemAtIndexCallback(
            findNodeHandle(this), 
            index,
            callbakc
        );
    }

    fetchItemViewAtPointHandler(point, resolve, reject) {
        RNiCarouselManager.fetchItemViewAtPointHandler(
            findNodeHandle(this), 
            point,
            resolve,
            reject
        );
    }

    removeItemAtIndexAnimated(index, animated) {
        RNiCarouselManager.shouldRemoveItemAtIndexAnimated(
            findNodeHandle(this),
            index, 
            animated
        );
    }

    insertItemAtIndexAnimated(index, animated) {
        RNiCarouselManager.shouldInsertItemAtIndexAnimated(
            findNodeHandle(this),
            index,
            animated
        );
    }

    reloadItemAtIndexAnimated(index, animated) {
        RNiCarouselManager.shouldReloadItemAtIndexAnimated(
            findNodeHandle(this), 
            index,
            animated
        );
    }

    render() {
        return <RNiCarousel {...this.props} />;
    }
}

/**
 * RCTCardView
 */
class RCTCellView extends React.Component {
    constructor(props) {
        super(props);
        this.state = {width:0, height:0};
    }
    static propTypes = {
        title: PropTypes.string,
        backgroundImageURL: PropTypes.string
    }
    render() {
        return <RNCardView 
                    onLayout={(event)=>{this.setState(event.nativeEvent.layout)}} 
                    {...this.props} 
                    componentWidth={this.state.width} 
                    componentHeight={this.state.height} 
                />
    }
};
var RNCardView = requireNativeComponent('RCTCardView', RCTCellView);

RCTiCarousel.Cell = RCTCellView;
RCTiCarousel.Type = RNiCarouselType;

/**
 * exports
 */
module.exports = RCTiCarousel;