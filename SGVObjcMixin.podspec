#
# Be sure to run `pod lib lint SGVObjcMixin.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SGVObjcMixin"
  s.version          = "1.0.0"
  s.summary          = "Dynamic class creation and runtime subclassing as a more granular and reversible alternative to method swizzling."
  s.description      = <<-DESC
                       SGVObjcMixin allows to 'mix in' methods from another class into any existing object (of any class). The class being mixed in should meet certain requirements.
                       This can be used as an object-scoped (versus class-scoped) alternative to method swizzling. It is also arguably easier to reverse at runtime if needed.
                       DESC
  s.homepage         = "https://github.com/sanekgusev/SGVObjcMixin"
  s.license          = 'MIT'
  s.author           = { "Alexander Gusev" => "sanekgusev@gmail.com" }
  s.source           = { :git => "https://github.com/sanekgusev/SGVObjcMixin.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/sanekgusev'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'

  s.public_header_files = 'Pod/Classes/SGVObjcMixinErrors.h', 'Pod/Classes/NSObject+SGVObjcMixin.h'
end
