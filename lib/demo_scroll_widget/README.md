可滚动的Widget

当内容超过显示视口(ViewPort)时,Flutter默认会提示报错.

一般用滚动的widget进行处理该问题.

共同属性:
```$xslt

Scollable({
   this.axisDirection = AxisDirection.down //滚动方向
   this.controller //接受一个scrollController 主要用于控制滚动位置和滚动事件的监听.默认使用PrimaryScrollController 
   this.physics  //接受一个ScrollPhysics对象,决定滚动的weidget如何响应用户的操作. CalmpingScrollPhysics android下的微光效果 
                   BouncingScrollPhysics ios弹性效果. 
   @required this.viewportBuilder 
})

```

ScrollBar

如果要给可滚动的widget添加滚动条,只需要将scrollbar作为可滚动的widget的父控件即可.

CupertinoScrillBar

ios风格的scrollBar

ViewPort视口

一个Widget显示的实际区域/

主轴和纵轴

滚动方向为主轴 非滚动方向为纵轴.






