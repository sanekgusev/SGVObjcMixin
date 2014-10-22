# SGVObjcMixin

[![CI Status](http://img.shields.io/travis/Alexander Gusev/SGVObjcMixin.svg?style=flat)](https://travis-ci.org/Alexander Gusev/SGVObjcMixin)

Dynamic class creation and runtime subclassing as a more granular and reversible alternative to method swizzling.

SGVObjcMixin allows to 'mix in' instance methods from another class into any existing object (of any class). 
The class being mixed in should meet certain requirements, namely: 

* It's immediate superclass must be in the inheritance hierarchy of the object to be mixed into.
* It is not allowed to introduce any new ivars (either explicit, or implicit from automatic property synthezation).

This mixin approach can be used as an object-scoped (versus class-scoped), opt-in alternative to method swizzling. It is also arguably easier to reverse at runtime if needed.

## Usage

Use the provided SGVObjcMixin category on NSObject to mixin and un-mixin instance methods from other classes.

## Requirements 

## Installation

SGVObjcMixin is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "SGVObjcMixin"

## Author

Alexander Gusev, sanekgusev@gmail.com

## License

SGVObjcMixin is available under the MIT license. See the LICENSE file for more info.

