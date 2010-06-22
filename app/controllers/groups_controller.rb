class GroupsController < ApplicationController
  def index
    @contacts = Contact.all(:include => [:group])
    @contact = Contact.new
    @groups = Group.all
    @group = Group.new
  end
  def create
    @group = Group.new(params[:group])
    respond_to do |format|
      format.js do |page|
        if @group.save
          render :update do |page|
            page.insert_html(:bottom, 'groups_list', :partial => @group)
          end
        end
      end
    end
  end
end
