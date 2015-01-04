

@MainScene = cc.Scene.extend

  onEnter: ->
    @_super()
    layer = new MainLayer()
    @addChild layer


MainLayer = cc.Layer.extend
  ctor: ->
    @_super()
    sprite = new cc.TMXTiledMap res.zeldabg_tmx
    sprite.x = 0
    sprite.y = 0
    @addChild sprite, 0
