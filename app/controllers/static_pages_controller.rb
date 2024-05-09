class StaticPagesController < ApplicationController
  def home
  end

  def login
    if logged_in
      redirect_to root_url
    end
  end

  def profile
    if !logged_in
      redirect_to root_url
    end
  end
end
