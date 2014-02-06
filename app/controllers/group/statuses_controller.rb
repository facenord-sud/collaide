class Group::StatusesController < ApplicationController

  #GET /group/:id/statuses
  def index
    @group = Group::Group.find(params[:work_group_id])
    @status = Status.new
    @statuses = Group::Group.find(params[:work_group_id]).statuses.includes(:comments)
  end
end