class StaticPagesController < ApplicationController
  def about
    render partial: "about"
  end
end
