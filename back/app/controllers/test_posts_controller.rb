class TestPostsController < ApplicationController
  # GET /test_posts
  def index
    @test_posts = TestPost.all

    render json: @test_posts
  end
end
