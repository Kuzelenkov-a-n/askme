class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Andrew',
        username: '_andrew_',
        avatar_url: 'https://goodprogrammer.ru/system/avatars/000/016/211/aa680b6a02af38e87e25667db84ccbd62375de40_x300.jpg?1607677928'
      ),
      User.new(
        id: 2,
        name: 'Anton',
        username: '_tcg_'
      )
    ]
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

    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('05.04.2021')),
      Question.new(text: 'Как настроение?', created_at: Date.parse('05.04.2021')),
      Question.new(text: 'Существует параллельная вселенная?', created_at: Date.parse('06.04.2021')),
      Question.new(text: 'Что было первым яйцо или курица?', created_at: Date.parse('06.04.2021'))
    ]

    @new_question = Question.new
  end
end
