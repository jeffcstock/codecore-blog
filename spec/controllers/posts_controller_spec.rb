require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe '#new' do
    it 'renders new template' do
      get :new
      expect(response).to render_template(:new)
    end
    it 'creates a new post object in memory @post' do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe '#create' do
    context 'with valid params' do
      it 'creates a new post object and saves' do
        count_before = Post.count
        post :create, params: {post: FactoryGirl.attributes_for(:post)}
        count_after = Post.count
        expect(count_after).to eql(count_before + 1)
      end
      it 'redirects to the show page' do
        post :create, params: {post: FactoryGirl.attributes_for(:post)}
        expect(response).to redirect_to(post_path(Post.last))
      end
    end

    context 'with invalid params' do
      def invalid_request
        post :create, params: {
                        post: FactoryGirl.attributes_for(:post, title: nil) }
      end
      it 'doesn\'t save the new post object' do
        count_before = Post.count
        invalid_request
        count_after = Post.count
        expect(count_after).to eql(count_before)
      end
      it 'renders the "new" view' do
        invalid_request
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'loads all posts in instance variable' do
      get :index
      POSTS_PER_PAGE = 10
      p = Post.order(created_at: :desc).limit(POSTS_PER_PAGE).offset(@page.to_i * POSTS_PER_PAGE)
      expect(assigns(:post)).to eq(p)
    end
  end

  describe '#show' do
    it 'renders show view' do
      post = FactoryGirl.create :post
      get :show, params: {id: post.id}
      expect(response).to render_template(:show)
    end
    it 'loads single post in @post' do
      p = FactoryGirl.create :post
      get :show, params: {id: p.id}
      expect(assigns(:post)).to eql(p)
    end

  end

  describe '#destroy' do
    let (:post) { FactoryGirl.create(:post) }

    it 'deletes post from database' do
      delete :destroy, params: {id: post.id}
      expect(Post.count).to eq(0)
    end
    it 'redirects to the index view' do
      delete :destroy, params: {id: post.id}
      expect(response).to redirect_to(posts_path)
    end

  end

  describe '#edit' do
    let (:post) { FactoryGirl.create(:post) }
    it 'renders edit view' do
      get :edit, params: {id: post.id}
      expect(response).to render_template(:edit)
    end
    it 'finds post by id @post' do
      get :edit, params: {id: post.id}
      expect(assigns(:post)).to eq(post)
    end
  end

  describe '#update' do
    let (:p) { FactoryGirl.create(:post) }
    it 'finds post params and stores it in @post' do
      patch :update, params: { id: p.id, post: {title: 'My edited title'}}
      expect(assigns(:post)).to eql(p)
    end

    it 'saves edited post to database' do
      patch :update, params: { id: p.id, post: {title: 'My edited title'}}
      expect(p.reload.title).to eq('My edited title')
    end

    it 'redirects to post page' do
      patch :update, params: { id: p.id, post: {title: 'My edited title'}}
      expect(response).to redirect_to(post_path(p))
    end
  end
end
