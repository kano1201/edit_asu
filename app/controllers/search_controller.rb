class SearchController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == 'user'
      @records = User.search_for(@content, @method).page(params[:page]).reverse_order
    else
      @records = Photo.search_for(@content, @method).page(params[:page]).reverse_order
    end
  end
  
end

#バリデーション