class StaticPagesController < ApplicationController
  def home
    @hello = "こんにちは"
  end
end
