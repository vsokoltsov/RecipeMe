class RecipeMe.Views.UserProfile extends Backbone.View
  template: JST['users/profile']
  'events':
    'click .edit-profile': 'showModalEdit'
    'click .toggle-user-recipes': 'toggleUserRecipes'

  initialize: (params)->
    @params = params
    this.render()

  render: ->
    $(@el).html(@template({user: @params.user}))
    this

  toggleUserRecipes: (event)->
    button = $(event.target)
    if button.hasClass("glyphicon-arrow-up")
      $(".user-recipes-body").html("")
      button.removeClass("glyphicon-arrow-up").addClass("glyphicon-arrow-down")
    else
      @params.recipes.each(@showRecipe)
      button.removeClass("glyphicon-arrow-down").addClass("glyphicon-arrow-up")


  showRecipe: (recipe) ->
    view = new RecipeMe.Views.ProfileRecipe({model: recipe})
    $(".user-recipes-body").append(view.el)
    view.render()

  showModalEdit: ->
    modal = new RecipeMe.Views.CommonModal()
    $("#myModal").html(modal.el).modal('show')
    view = new RecipeMe.Views.EditProfile({user: @params.user})
    modal.render()
    $("#myModal .modal-title").html("<h3>Редактировать пользователя</h3>")
    $("#myModal .modal-body").html(view.el)
    view.render()

