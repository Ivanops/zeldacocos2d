layer = null
sprite = null
counter = 1
time = 0

@touchListener = (target) ->
  cc.eventManager.addListener
    event: cc.EventListener.TOUCH_ALL_AT_ONCE
    swallowTouches: yes,
    onTouchesBegan: target.onTouchesBegan
    onTouchesMoved: target.onTouchesMoved
    onTouchesEnded: target.onTouchesEnded
  , target

HelloWorldLayer = cc.Layer.extend

  ctor: ->

    @_super()
    layer = @
    cc.spriteFrameCache.addSpriteFrames res.walk_plist
    spriteCache = cc.textureCache.addImage res.walk_png

    touchListener @

    bg = new cc.TMXTiledMap res.zeldabg_tmx
    bg.x = 0
    bg.y = 0
    @addChild bg, 0


    spriteBatch = new cc.SpriteBatchNode spriteCache
    spriteBatch.setBlendFunc(cc.SRC_ALPHA, cc.ONE) if cc.sys.isNative

    frames = []
    for i in [1 .. 10]
      index = if i < 10 then '0' + i else i
      frames.push cc.spriteFrameCache.getSpriteFrame "walk_#{index}.png"

    animation = new cc.Animation frames, 0.1
    cc.animationCache.addAnimation animation, 'walk'

    @addChild spriteBatch

    sprite = new cc.Sprite(cc.spriteFrameCache.getSpriteFrame('walk_01.png'))

    console.log cc.spriteFrameCache
    sprite.setAnchorPoint .5, .5

    cc.log sprite.height

    size = cc.winSize

    sprite.x = size.width / 2
    sprite.y = size.height / 2
    sprite.setScale 1


    @addChild sprite, 1
    @scheduleUpdate()

    true

  update: (dt) ->
    time += dt
    sprite.update(dt)
    if time > .1
      counter = 1 if counter > 10
      index = if counter < 10 then '0' + counter else counter
      sprite.setSpriteFrame cc.spriteFrameCache.getSpriteFrame('walk_' + index + '.png')
      counter++
      time = 0

  onTouchesBegan: (touches) ->

    location = touches[0].getLocation()

    sprite.stopAllActions()
    time = cc.pDistance(cc.p(sprite.x, sprite.y), location) / 100
    cc.log time

    sprite.runAction(new cc.moveTo(time, location))


@HelloWorldScene = cc.Scene.extend
  onEnter: ->
    @_super()
    layer = new HelloWorldLayer()
    @addChild layer
