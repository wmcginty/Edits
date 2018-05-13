# Edits
[![CI Status](http://img.shields.io/travis/wmcginty/Edits.svg?style=flat)](https://travis-ci.org/wmcginty/Edits)
[![codecov](https://codecov.io/gh/wmcginty/Edits/branch/master/graph/badge.svg)](https://codecov.io/gh/wmcginty/Edits)
[![Version](https://img.shields.io/cocoapods/v/Edits.svg?style=flat)](http://cocoapods.org/pods/Edits)
[![License](https://img.shields.io/cocoapods/l/Edits.svg?style=flat)](http://cocoapods.org/pods/Edits)
[![Platform](https://img.shields.io/cocoapods/p/Edits.svg?style=flat)](http://cocoapods.org/pods/Edits)

## Purpose

This library aims to provide a simplified interface for determing the difference between two collections, and then easily surfacing those changes to the user.
* Wrap up an implementation of the [Levenshtein Distance](https://en.wikipedia.org/wiki/Levenshtein_distance) algorithm.
* Easily animate these changes using the built in UITableView and UICollectionView.


## Usage

### 1. Create A Transformer

Create a `Transformer` object, supplying it with the source and the destination collection:

```swift
 let transformer1 = Transformer(source: "hello", destination: "olleh")
```
At this point, you can simply query the transformer for the minimum number of edits to complete the transformer, or for the steps themselves (lazily calculated):

```swift
print(transformer1.minEditDistance) //4
print(transformer1.editSteps) // [AnyEditor<String>]
```
You can now easily apply this transformation to a UITableView or UICollectionView in a single line:

```swift
let tv = UITableView(frame: .zero)
tv.processUpdates(for: transformer1, inSection: 0)

let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
cv.processUpdates(for: transformer1, inSection: 0)
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS 8.0+
* Swift 4 (Xcode 9)

## Installation

Edits is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Edits"
```

## Author

William McGinty, mcgintw@gmail.com

## License

Edits is available under the MIT license. See the LICENSE file for more info.
