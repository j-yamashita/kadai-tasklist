class TasksController < ApplicationController
  
  before_action :require_user_logged_in
  
  def index
    # @tasks = Task.all
    # @tasks = Task.all.page(params[:page]) # kaminariを使うため.page(params[:page])を追加
    @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
  end
    
  def create
    # createアクションに対応するビューは用意しない。出口はredirect_toかrenderのいずれか。
    # new.html.erbのform_for(@task)によって、自動的に送信先が選ばれる。
    # @taskが新規ならcreateが、既存ならupdateが呼ばれる。
    
    # @task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = "投稿されました"
      redirect_to @task   # task_path(@task)と同じ。/tasks/:idへリダイレクト。showアクションが呼ばれる。
    else
      flash.now[:danger] = "投稿できませんでした"
      render :new         # newアクションは実行せず、単にnew.html.erbを表示。
    end
  end
  
  def new
    # @task = Task.new
    @task = current_user.tasks.build
  end
  
  def edit
    # @task = Task.find(params[:id])
    correct_user
  end
  
  def show
    # @task = Task.find(params[:id])
    correct_user
  end
  
  def update
    # updateアクションに対応するビューは用意しない。出口はredirect_toかrenderのいずれか。
    
    # @task = Task.find(params[:id])
    correct_user
    
    if @task.update(task_params)
      flash[:success] = "更新されました"
      redirect_to @task     # /tasks/:idへリダイレクト。showアクションが呼ばれる。
    else
      flash.now[:danger] = "更新できませんでした"
      render :edit          # edit.html.erbを表示。
    end
  end
  
  def destroy
    # destroyアクションに対応するビューは用意しない。
    # show.html.erbのリンクから、tasks/:idにDELETEメソッドを送信することで呼ばれる。
    
    # @task = Task.find(params[:id])
    correct_user
    
    @task.destroy
    flash[:success] = "削除されました"
    redirect_to tasks_url     # /tasks へのリンク。indexアクションへ行く。
  end
    
  private
  
  def task_params
    params.require(:task).permit(:content, :status)    # taskモデルのcontentカラムとstatusカラムのみ受け取る
  end
  
  def correct_user
    # /tasks/:id で受け取ったparams[:id]が、現在ログインしているユーザーのtaskのidであるか否かをチェック
    # 正しければそのtaskを操作対象にするため@taskを返す
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
end

