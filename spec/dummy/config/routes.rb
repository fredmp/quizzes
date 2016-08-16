Rails.application.routes.draw do
  mount Quizzes::Engine => "/quizzes"
end
