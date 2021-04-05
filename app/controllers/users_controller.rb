class UsersController < ApplicationController
  def index
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Andrew',
      username: '_andrew_',
      avatar_url: 'https://goodprogrammer.ru/system/avatars/000/016/211/aa680b6a02af38e87e25667db84ccbd62375de40_x300.jpg?1607677928'
    )
  end
end
