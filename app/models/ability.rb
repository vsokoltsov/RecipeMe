class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    if user
      user.is_admin? ? admin_abilities : current_user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :locale, User
    can [:read, :recipe_ingridients], [Recipe, Category, Ingridient, Step, Callback, News, Comment]
    can [:read, :create], Callback
    can [:read, :recipes], Category

  end

  def current_user_abilities
    guest_abilities
    can :create, Recipe
    can [:update, :destroy], Recipe, user_id: @user.id
    can [:create, :destroy, :update], Ingridient
    can [:create, :update, :destroy], Step
    can [:create, :destroy, :index], Relationship
    can :create, Image
    can :create, Comment
    can [:update, :destroy], Comment, user_id: @user.id
    can [:read, :following, :followers], User
    can [:feeds, :update, :destroy], User, id: @user.id
    can :read, Feed
  end

  def admin_abilities
    can :manage, :all
  end
end
