class GroupsController < ApplicationController
  before_filter :find_list
  
  def index
    if current_user
      @contacts = @list.contacts
      @groups = @list.groups
      @contacts_list = Contact.listing(@list)
    else
      redirect_to login_path
    end
  end
  
  def create
    @group = @list.groups.build(params[:group])
    respond_to do |format|
      format.js do
        render :update do |page|
          if @group.save
            page.insert_html :bottom, 'groups_container', :partial => 'groups/group', :object => @group
            page.replace 'edit_container', '<div id="edit_container"></div>'
          else
            page.alert("Group can not be created")
          end
        end
      end
    end
  end
  
  def show_contacts
    @group = @list.groups.find(params[:id])
    @contacts = @group.contacts
    respond_to do |format|
      format.js do
        render :update do |page|
          unless @contacts.empty?
            @contacts.sort!{|f,g| f.name <=> g.name}
            page.replace_html 'contacts_container', :partial => @contacts
          else
            page.replace 'contacts_container', '<div id="contacts_container"></div>'
          end
          page.replace 'edit_container', :partial => "/groups/simple_group", :object => @group
        end
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
    @group = Group.find(params[:id])
    @group.delete_contacts
    @group.destroy
    @groups = Group.all
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace 'edit_container', '<div id="edit_container"></div>'
          page.replace 'edit_group_container', '<div id="edit_group_container"></div>'
          page.replace_html 'groups_container', :partial => @groups
        end
      end
    end
  end
  def find_list
    @user = User.find_by_username(current_user.username)
    @list = List.find_by_id(@user.id)
  end
end
