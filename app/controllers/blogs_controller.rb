class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :check_login, only: [:new, :show, :edit, :update, :destroy]
  # before_action :set_group_id, only: [:new, :show, :edit, :update, :destroy]
  # before_action :set_user_id, only: [:new, :show, :edit, :update, :destroy]
  
  def index
    if flash[:id].present? #blog_createから受け取ったgroup_id変数がある場合
      @group = Group.find(flash[:id]) #選択したグループのidを保存。
      @blogs = Blog.where(group_id: flash[:id])
    else
      @group = Group.find(params[:id]) #選択したグループのidを保存。
      if Blog.where(group_id: params[:id])
        @blogs = Blog.where(group_id: params[:id])
      end
    end
  end
  
  # Viewへの操作
  def new
    if params[:back]
      puts "aaaaaaaaaaaaaaaaaaaaaa"
      puts params
      @group = Group.find(params[:blog][:user_id]) #選択したグループのidを保存。
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
      @blog.user_id = current_user.id #現在ログインしているuserのidをblogのuser_idカラムに挿入する。
      if flash[:id].present? #blog_createから受け取ったgroup_id変数がある場合
        @blog.group_id = flash[:id]
        @group = Group.find(flash[:id]) #選択したグループのidを保存。
      else
        @blog.group_id = params[:id] #選択したグループのidをgroup_idカラムに挿入する。
        @group = Group.find(params[:id]) #選択したグループのidを保存。
      end
    end
  end
  
  # Modelへの操作
  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id #現在ログインしているuserのidをblogのuser_idカラムに挿入する
    @blog.group_id = params[:blog][:group_id]
    @group = Group.find(params[:blog][:group_id]) #選択したグループのidを保存。
    if @blog.save
      # 一覧画面へ遷移して"投稿を作成しました！"とメッセージを表示します。
      redirect_to blogs_path, notice: "Successfully Created", flash: { id: params[:blog][:group_id] }
    else
      # 入力フォームを再描画します。
      render 'new'
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "Successfully Edited"
    else
      render 'edit'
    end
  end
  
  def destroy
    tmp_group_id = @blog[:group_id]
    @blog.destroy
    redirect_to blogs_path, notice:"Successfully Deleted", flash: { id: tmp_group_id }
  end
  
  def confirm
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id #現在ログインしているuserのidをblogのuser_idカラムに挿入する。
    @blog.group_id = params[:blog][:group_id]
    @group = Group.find(params[:blog][:group_id]) #選択したグループのidを保存。
    render :new if @blog.invalid?
  end
  
  
  # メソッドとして切り出し。privateを指定することで、BlogsControllerクラス内でしか呼び出せない
  private
  def blog_params
    params.require(:blog).permit(:title, :content)
  end
  
  def set_blog
    @blog = Blog.find(params[:id])
  end
  
  def check_login
    if not logged_in?
      redirect_to new_session_path
    end
  end
  
  def set_group_id
    @group = Group.find(params[:id])
  end
  
end
