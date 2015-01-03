HelloWorldLayer = cc.Layer.extend

  ctor: ->

    @_super()

    cc.spriteFrameCache.addSpriteFrames 'res/walksdadcas.plist'
    spriteCache = cc.textureCache.addImage 'res/walksdadcas.png'


    spriteBatch = new cc.SpriteBatchNode spriteCache

    frames = []
    for i in [1 .. 10]
      index = if i < 10 then '0' + i else i
      frames.push cc.spriteFrameCache.getSpriteFrame "walk_#{index}.png"

    animation = new cc.Animation frames, 0.1
    cc.animationCache.addAnimation animation, 'walk'

    @addChild spriteBatch

    #sprite = new cc.Sprite(cc.spriteFrameCache.getSpriteFrame('walk_01.png'))

    console.log cc.spriteFrameCache

    size = cc.winSize

    #sprite.x = size.width / 2
    #sprite.y = size.height / 2

    #@addChild sprite

    true

@HelloWorldScene = cc.Scene.extend
  onEnter: ->
    @_super()
    layer = new HelloWorldLayer()
    @addChild layer
