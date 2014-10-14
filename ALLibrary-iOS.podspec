Pod::Spec.new do |s|
s.name         = "ALLibrary-iOS"
s.version      = "1.7"
s.summary      = "站在巨人的肩膀上，针对RTALLibrary-ios进行了扩展和修改，主要是针对自己使用的项目做一些优化。后续会慢慢添加需要的东西"
s.homepage     = "https://github.com/z306007236/ALLibrary-iOS.git"
s.license      = 'MIT'
s.author       = { "Allen" => "yu.zhang@foxmail.com" }
s.source       = { :git => "https://github.com/z306007236/ALLibrary-iOS.git", :tag => "1.7" }
s.source_files = 'ALLibrary-iOS/*.{h,m}'
s.platform     = :ios, '7.0'
s.framework    = 'UIKit'
s.requires_arc = true

#PodDependencies
s.dependencies=	pod"AFNetworking","~>2.0"
s.dependencies=	pod'Reachability','~>3.1.1'
s.dependencies=	pod'SVProgressHUD','~>1.0'
s.dependencies=	pod'FMDB','~>2.3'
end