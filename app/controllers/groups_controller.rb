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
        if @group.save
          render :update do |page|
            page.insert_html(:bottom, 'groups_list', :partial => @group)
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
  
end
