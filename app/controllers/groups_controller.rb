class GroupsController < ApplicationController
  def index
    @contacts = Contact.all()
    @contact = Contact.new
    @groups = Group.all
    @group = Group.new
  end
  def create
    @group = Group.new(params[:group])
    respond_to do |format|
      format.js do |page|
        render :update do |page|
          if @group.save
            page.insert_html(:bottom, 'groups_list', :partial => @group)
          else
            page.alert("Group can be created")
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
            page.replace 'contacts_container', :partial => @contacts
          end
        end
      end
    else
      render :update do |page|
        page.alert("No contacts")
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
  
  def clear_form
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace_html 'edit_container', '<div id="edit_container"></div>'
        end
      end
    end
  end
end
