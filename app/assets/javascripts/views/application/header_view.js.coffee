class RecipeMe.Views.HeaderView extends Backbone.View

  template: JST['application/header']

  events:
    "click .login-window": 'loginDialog'
    "click .registration-window": 'registrationDialog'
    "click .sign-out-button": 'signOut'
    "click .menu-item": 'showNavigationMenu'

  initialize: ->
    this.render()
    @width = $(".app-header").width()
    @navigation_width = 300

  loginDialog: ->
    modalView = new RecipeMe.Views.ModalWindow({el: ".modal"})
    login = new RecipeMe.Views.LoginView({el: ".actions-views"})

  registrationDialog: ->
    modalView = new RecipeMe.Views.ModalWindow({el: ".modal"})
    registration = new RecipeMe.Views.RegistrationView({el: ".actions-views"})

  signOut: ->
    $.ajax "/users/sign_out",
      type: "DELETE"
      success: (data, textStatus, jqXHR) ->
        window.location.reload()
      error: (jqXHR, textStatus, errorThrown) ->
        console.log jqXHR.responseText

  showNavigationMenu: ->
    this.toggleLeftMenu()


  toggleLeftMenu: ->
    if $("#navigationMenu").width() == 0
      $(".app-header").animate({width: "#{@width - @navigation_width}px", left: "#{@navigation_width}px"}, 250)
      $("#navigationMenu").show().animate({width: "#{@navigation_width}"}, 250)
      $(".mask").removeClass("hide")
    else
      $(".app-header").animate({width: "100%", left: "0px"}, 250)
      $("#navigationMenu").show().animate({width: "0px"}, 250)
      $(".mask").addClass("hide")



  render: ->
    $(@el).html(@template())
    this