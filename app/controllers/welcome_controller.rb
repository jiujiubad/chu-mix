class WelcomeController < ApplicationController
  def index
    flash[:notice] = "测试 flash 功能是否成功使用！"
  end
end
