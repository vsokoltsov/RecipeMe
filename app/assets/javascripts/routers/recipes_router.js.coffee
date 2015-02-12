class RecipeMe.Routers.Recipes extends Backbone.Router
  routes:
    '':'application'
    'recipes': 'index'
    'recipes/page/:page': 'index'
    'recipes/new': 'newRecipe'
    'recipes/:id': 'showRecipe'
    'recipes/:id/edit': 'editRecipe'
    'users/:id': 'userProfile'
    'users/:id/recipes': 'userRecipes'
    'users/:id/edit': 'editProfile'

  initialize: ->
    this.setup()
    @collection = new RecipeMe.Collections.Recipes()
    @collection.fetch()
    RecipeMe.recipesCollection = @collection

  application: ->


  setup: ->
    if(!this.ApplicationView)
      new RecipeMe.Views.ApplicationView({el: 'body'})

  index:->
    new RecipeMe.RecipesController().index()

  newRecipe: ->
    this.setup()
    view = new RecipeMe.Views.RecipesForm({collection: @collection})
    $("section#main").html(view.el)
    view.render()

  showRecipe: (id) ->
    this.setup()
    recipe = new RecipeMe.Models.Recipe(id: id)

    recipe.fetch
      success: (model)->
        view = new RecipeMe.Views.RecipeShow(model: model)
        $("section#main").html(view.el)
        view.render()

  editRecipe: (id) ->
    recipe = new RecipeMe.Models.Recipe(id: id)
    recipe.fetch
      success: (model)->
        view = new RecipeMe.Views.RecipesForm({model: model})
        $("section#main").html(view.el)
        view.render()

  userProfile: (id) ->
    if RecipeMe.currentUser
      user_recipes = new RecipeMe.Collections.Recipes(@collection.currentUserRecipes())
      profile = new RecipeMe.Views.UserProfile({user: RecipeMe.currentUser, recipes: user_recipes})
      $("section#main").html(profile.el)
      profile.render()
    else
      Backbone.history.navigate('/recipes', {trigger: true, repalce: true})

  userRecipes: (id) ->
    if RecipeMe.currentUser
      user_recipes = new RecipeMe.Collections.Recipes(@collection.currentUserRecipes())
      view = new RecipeMe.Views.RecipesIndex({collection: user_recipes})
      $("section#main").html(view.el)
      view.render()
    else

  editProfile: (id) ->
    if RecipeMe.currentUser
      view = new RecipeMe.Views.EditProfile
      $("section#main").slideUp()
      $("section#main").html(view.el).slideDown()
      view.render()