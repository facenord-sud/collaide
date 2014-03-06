# -*- encoding : utf-8 -*-
class Group::RepoItemsController < ApplicationController
  #load_and_authorize_resource class: Group::RepositoriesController
  before_action :find_the_group

  # GET /group/work_groups/1
  # GET /group/work_groups/1.json
  def show
    @repo_item = RepositoryManager::RepoItem.find(params[:id])

    render status: :forbidden, :text => "No permission to see this repo_item" and return unless @group.can_read?(@repo_item)

    if @repo_item.is_folder?
      @children = @repo_item.children.order(name: :asc).order(file: :asc)
    else
      @children = []
    end
  end

  # Tout ce qui gère le repository
  def index
    @repo_item = @group.root_repo_items.order(name: :asc).order(file: :asc)
  end

  def create_file
    repo_item = RepositoryManager::RepoItem.find(params[:repo_item]) if params[:repo_item]

    respond_to do |format|
      if @item = @group.create_file(params[:repo_file_file], source_folder: repo_item, sender: current_user)
        format.html { redirect_to back, notice: t('repository_manager.success.repo_file.created') }
        format.json { render template: 'group/repo_items/create', status: :created }
      else
        format.html { redirect_to back, alert: t('repository_manager.errors.repo_file.not_created') }
        format.json { render json: {error: t('repository_manager.errors.repo_file.not_created')},  status: :unprocessable_entity }
      end
    end
  end

  def create_folder
    repo_item = RepositoryManager::RepoItem.find(params[:repo_item]) if params[:repo_item]
    respond_to do |format|
      if @item = @group.create_folder(params[:repo_folder_name], source_folder: repo_item, sender: current_user)
        format.html { redirect_to back, notice: t('repository_manager.success.repo_folder.created') }
        format.json { render template: 'group/repo_items/create', status: :created }
      else
        format.html { redirect_to back, alert: t('repository_manager.errors.repo_folder.not_created') }
        format.json { render json: {error: t('repository_manager.errors.repo_folder.not_created')}, status: :unprocessable_entity }
      end
    end
  end

  def download
    @repo_item = RepositoryManager::RepoItem.find(params[:repository_id])

    # Pris chez Numa
    # méthode d'envoi de fichier :default -> pour le local
    if Rails.env = 'production'
      logger.debug 'On est en production, donc on utilise apache'
      send_file_method = :apache
    else
      send_file_method = :default
    end

    path = @group.download(@repo_item)
    logger.debug path.inspect

    # Si le fichier n'est pas trouvé
    render status: :bad_request and return unless File.exist?(path)

    p MIME::Types.type_for(path).inspect

    unless MIME::Types.type_for(path).empty?
      send_file_options = { :type => MIME::Types.type_for(path).first.content_type, disposition: :inline }
    else
      send_file_options = { disposition: :inline }
    end

    case send_file_method
      when :apache then send_file_options[:x_sendfile] = true
      when :nginx then head(
          :x_accel_redirect => path.gsub(Rails.root, ''),
          #:content_type => send_file_options[:type]
      ) and return
    end

    # on envoie le fichier
    send_file(path, send_file_options)
    #send_file(path)
  end

  def destroy
    @repo_item = RepositoryManager::RepoItem.find(params[:id])

    if @repo_item.is_folder?
      notice = t'repository_manager.destroy.repo_folder.success', item: @repo_item.name
      notice_failed = t'repository_manager.destroy.repo_folder.failed', item: @repo_item.name
    else
      notice = t'repository_manager.destroy.repo_file.success', item: @repo_item.name
      notice_failed = t'repository_manager.destroy.repo_folder.failed', item: @repo_item.name
    end
    respond_to do |format|
      if @group.delete_repo_item(@repo_item)
        format.html { redirect_to :back, notice: notice }
        format.json { render template: 'group/repo_items/show', status: :ok }
      else
        format.html { redirect_to :back, alert: notice_failed }
        format.json { render json: {error: notice_failed}, status: :unprocessable_entity}
      end
    end
  end

  private
  def find_the_group
    @group = Group::Group.find(params[:work_group_id])
  end
end
