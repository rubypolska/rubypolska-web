# frozen_string_literal: true

module Blog
  class PostsController < ApplicationController
    before_action :set_post, only: [:show]

    def index
      @posts = Post.order(created_at: :desc)
                   .page(params[:page])
                   .per(9)
    end

    def show; end

    private

    def set_post
      @post = Post.friendly.find(params[:id])
    end
  end
end
