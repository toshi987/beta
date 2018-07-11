class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :check_login, only: [:index, :new, :show, :edit, :update, :destroy]
  
  def index
    @groups = Group.all
  end
  
  # Viewへの操作
  def new
    if params[:back]
      @group = Group.new(group_params)
    else
      @group = Group.new
      @group.user_id = current_user.id #現在ログインしているuserのidをgroupのuser_idカラムに挿入する。
    end
  end
  
  # Modelへの操作
  def create
    @group = Group.new(group_params)
    @group.user_id = current_user.id #現在ログインしているuserのidをgroupのuser_idカラムに挿入する。
    if @group.save
      # 一覧画面へ遷移して"グループを作成しました！"とメッセージを表示します。
      redirect_to groups_path, notice: "Successfully Created"
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
    if @group.update(group_params)
      redirect_to groups_path, notice: "Successfully Edited"
    else
      render 'edit'
    end
  end
  
  def destroy
    @group.destroy
    redirect_to groups_path, notice:"Successfully Deleted"
  end
  
  def confirm
    @group = Group.new(group_params)
    render :new if @group.invalid?
  end
  
  
  # メソッドとして切り出し。privateを指定することで、GroupsControllerクラス内でしか呼び出せない
  private
  def group_params
    params.require(:group).permit(:groupname, :content, :user_id)
  end
  
  def set_group
    @group = Group.find(params[:id])
  end
  
  def check_login
    if not logged_in?
      redirect_to new_session_path
    end
  end
  
end
