Pod::Spec.new do |s|
  s.name         = "ZCNavigationController"
  s.version      = "0.0.1"
  s.summary      = "导航上拉渐变"
  s.homepage     = "https://github.com/xiaowu2016/ZCNavigationController"
 
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "zhangchao" => "942777491@qq.com" }
  
  s.platform     = :ios, "5.0"

  s.source       = { :git => "https://github.com/xiaowu2016/ZCNavigationController.git", :tag => "0.0.1" }


  s.source_files  = "Classes", "ZCNavigationController/*.{h,m}"

end
