class GroupsController < ApplicationController
  def index
    @contacts = Contact.all
    @groups = Group.all
  end
  
  def create
    @group = Group.new(params[:group])
    respond_to do |format|
      format.js do
        render :update do |page|
          if @group.save
            page.insert_html(:bottom, 'groups_list', :partial => 'groups/group', :object => @group)
            page.alert("Group created")
          else
            page.alert("Group can not be created")
          end
        end
      end
    end
  end
  
  def show_contacts
    @group = Group.find(params[:id])
    @contacts = @group.contacts
    unless @contacts.empty?
      @contacts.sort!{|f,g| f.name <=> g.name}
      respond_to do |format|
        format.js do
          render :update do |page|
            page.replace_html 'contacts_container', :partial => @contacts
            page.replace_html 'edit_group_container', :partial => "/groups/simple_group", :object => @group
          end
        end
      end
    else
      render :update do |page|
        page.replace 'contacts_container', '<div id="contacts_container"></div>'
      end
    end
  end
  
  def display_new
    @group = Group.new
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace_html 'edit_container', :partial => '/groups/form', :object => @group
        end
      end
    end
  end
  
  def display_edit
    @group = Group.find(params[:id])
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace_html 'edit_container', :partial => '/groups/form', :object => @group
          page.replace 'edit_group_container', '<div id="edit_group_container"></div>'
        end
      end
    end
  end
  
  def clear_form
    @group = Group.find(params[:id])
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace 'edit_container', '<div id="edit_container"></div>'
          page.replace_html 'edit_group_container', :partial => "/groups/simple_group", :object => @group
        end
      end
    end
  end
  def destroy_group
    @groups = Group.all
    @group = Group.find(params[:id])
    @group.delete_contacts
    @group.destroy
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace 'edit_container', '<div id="edit_container"></div>'
          page.replace_html 'edit_group_container', :partial => "/groups/group", :collection => @groups
        end
      end
    end
  end
  
end
