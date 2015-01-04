cc.game.onStart = ->
  cc.view.setDesignResolutionSize 480, 320, cc.ResolutionPolicy.SHOW_ALL
  cc.view.resizeWithBrowserSize true
  cc.director.setProjection cc.Director.PROJECTION_2D

  if cc.sys.isNative
    searchPaths = jsb.fileUtils.getSearchPaths()
    searchPaths.push('script')
    if cc.sys.os is cc.sys.OS_IOS or cc.sys.os is cc.sys.OS_OSX
      searchPaths.push("res")
      searchPaths.push("src")

    jsb.fileUtils.setSearchPaths(searchPaths)


  #load resources
  cc.LoaderScene.preload g_resources, ->
    cc.director.runScene new HelloWorldScene()
  , this

cc.game.run()
