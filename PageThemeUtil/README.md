PageThemeUtil
=======

PageThemeUtil is a project for batch adding runtime page theme attribue and values to the xib files. 

PageThemeUtil 让项目中UIView支持不同主题的背景图片。


###必要条件

项目中必须有一套图片在 xib中设置为backgourdImage, 只有确定该套图片 PageThemeUtil才能依据该套图片， 在xib中为view增加新的runtime属性。




###安装及使用
0. 将需要使用的图片加入到原本项目中
1. 将PageThemeUtil拷贝进项目根目录
2. 编写image_map.json图片配置文件
3. 编译PageThemeUtil项目
4. 在需要实现主题功能的VeiwController中的viewwillappear增加
	```
   [[PageUtil pageUtil] changeImageForTheme:self.view];
```

###配置文件案例
####一, 初次使用
		[
			{"o":"btn_blank_01.png","r":"btn_blank_01_new.png"},
			{"o":"btn_blank_02.png","r":"btn_blank_02_new.png"},
			{"o":"btn_blank_03.png","r":"btn_blank_03_new.png"}
	    ]

#####二, 修改或者新增一套图片

		[
			{"o":"btn_blank_01.png","r":"btn_blank_043_new.png"},
			{"o":"btn_blank_02.png","r":"btn_blank_02_new.png"},
			{"o":"btn_blank_03.png","r":"btn_blank_03_new.png"},
			{"o":"btn_blank_03.png","r":"btn_blank_03_new.png"}
	    ]


#####三, 删除主题支持

**注意** : 

由于PageThemeUtil是通过 当前Xib中View的backgroundImage是否是image_map.json中的orangeImageName, 来搜索替换UIVeiew runtime属性的。

所以单纯的在image_map.json中删除掉该套图片， 会另脚本跳过使用该图片的UIView。而不会删除应该删除的主题。

正确的方法是  __将该套图片中的红色图片，留空或者替换为一个非 .png 结尾的字符串__

	正确：修改 "r": "" 中的redImageName字符串部分,不以 .png 结尾即可
		[
			{"o":"btn_blank_01.png","r":"   i don't need theme   "},
			{"o":"btn_blank_02.png","r":"btn_blank_02_new.png"},
			{"o":"btn_blank_03.png","r":"btn_blank_03_new.png"}
	    ]
	    
	    
	错误：只是删除改行数据
		[
			{"o":"btn_blank_01.png","r":"btn_blank_01_new.png"},
			{"o":"btn_blank_02.png","r":"btn_blank_02_new.png"}
	    ]



#####文件解释




* UIView+Addition

  为UIViewController中的View增加不同主题下使用图片的名称的属性。


* PageUtil

  做实际替换不同主题的图片操作， 需要支持使用主题的ViewController只用在ViewWillAppear中调用即可
  
  ```	
  [[PageUtil pageUtil] changeImageForTheme:self.view];
  ```

* image_map.json
	
  描述不同主题的下，View对应的背景图片, 例如:
  
  ```
  	[{"orange_theme":"orange_image_1.png", "red_theme":"red_image_2.png"}, .....]
  ```
   
  

* page_theme.rb
	
   根据当前背景图片名称， 为项目中的XIB文件批量对View主题相关的runtime属性赋值的脚本文件， 编译PageThemeUtil项目就会自动运行.
   

* findVCByImageName.rb 
	
   根据XIB中, UIVIew及其子类的 backgroundImage的内容， 来搜索输出包含该UIView的ViewController.
   
   		在命令行输入：
   
  		 ruby findVCByImageName.rb btn_blank_01.png

		输出：
		..beaOS7phonegap/BEA/iphone_src/SupremeGold/SupremeGoldOffersViewController.xib
		../beaOS7phonegap/BEA Delight/iphone_src/Classes/CardLoan/CardLoanApplyFormView.xib
		../beaOS7phonegap/BEA Delight/iphone_src/Classes/GlobePassView/GlobePassSummaryView.xib
		../beaOS7phonegap/BEA Delight/iphone_src/Classes/PBConcertsView/PBConcertsSummaryView.xib
		../beaOS7phonegap/ConsumerLoan/ConsumerLoanOffersViewController.xib

