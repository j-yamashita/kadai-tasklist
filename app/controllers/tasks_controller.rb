class TasksController < ApplicationController
  
  def index
    @tasks = Task.all
    
  end
    
    
  def create
    # createアクションに対応するビューは用意しない。出口はredirect_toかrenderのいずれか。
    # new.html.erbのform_for(@task)によって、自動的に送信先が選ばれる。
    # @taskが新規ならcreateが、既存ならupdateが呼ばれる。
    # http://railsdoc.com/references/form_for
    # http://ruby-rails.hatenadiary.com/entry/20140727/1406448610
    # https://qiita.com/shunsuke227ono/items/7accec12eef6d89b0aa9
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = "投稿されました"
      redirect_to @task   # task_path(@task)と同じ。/tasks/:idへリダイレクト。showアクションが呼ばれる。
    else
      flash.now[:danger] = "投稿できませんでした"
      render :new         # newアクションは実行せず、単にnew.html.erbを表示。
    end
  end
  
  def new
    @task = Task.new
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def update
    # updateアクションに対応するビューは用意しない。出口はredirect_toかrenderのいずれか。
    
    @task = Task.find(params[:id])
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
    @task = Task.find(params[:id])
    
    @task.destroy
    flash[:success] = "削除されました"
    redirect_to tasks_url     # /tasks へのリンク。indexアクションへ行く。
  end
    
  
  private
  
  def task_params
    params.require(:task).permit(:content)    # taskモデルのcontentカラムのみ受け取る
  end
  
end
