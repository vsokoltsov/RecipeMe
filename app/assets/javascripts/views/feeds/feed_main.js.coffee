class RecipeMe.Views.FeedMain extends Backbone.View
  template: JST["feeds/feed_main"]
  className: "feed-item"

  initialize: (params) ->
    if params.feed
      @feed = params.feed
      @user = @feed.get("follower_user")

  render: ->
    $(@el).html(@template({feed: @feed, user: @user}))
    if @feed.get("body")
      body = @feed.get("body")
      $(@el).find(".feed-body").html(body.render().el)
    this