class TestPostsController < ApplicationController

  def index
    @test_posts = TestPost.all

    render json: @test_posts
  end
end
