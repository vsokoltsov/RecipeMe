class RecipeMe.Views.NewsShow extends Backbone.View
  template: JST["news/show"]
  className: "news-show"
  events:
    'click .rate-icon': 'changeRate'
    'mouseover .rate-value': 'showVotedUsersPopup'
    'mouseleave .rate-value': 'hideVotedUsersPopup'
    'click .back-button': 'returnToNewsList'

  initialize: (params) ->
    if params
      @news = params.model

  changeRate: (event) ->
    if RecipeMe.currentUser
      new RecipeMe.Rate(@news).changeRate(
        success = (response, request) ->
          $(".rate-value").text(response.rate)
      )
    else
      return false

  showVotedUsersPopup: (event) ->
    if RecipeMe.currentUser || $(".popup-view")
      new RecipeMe.LikedUsers(@model).showUsersPopup()
    else
      return false

  hideVotedUsersPopup: (event) ->
    $(".popup-view").remove()
    $(".popup-view").fadeOut()

  returnToNewsList: (event)->
    event.preventDefault()
    Backbone.history.navigate('/news', {trigger: true, repalce: true})

  render: ->
    $(@el).html(@template(news: @news))
    this