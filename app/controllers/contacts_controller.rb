class ContactsController < ApplicationController
  before_filter :find_contact, :only => [:update, :destroy, :display_edit, :display_contact]
  before_filter :find_groups, :only => [:display_edit, :display_new]
  
  def create
    @contacts = Contact.all
    @contact = Contact.new(params[:contact])
    respond_to do |format|
      format.js do
        render :update do |page|
          if @contact.save
            unless @contact.group_id == nil
              page.replace_html 'groups_container', :partial => 'groups/group', :collection => Group.all
              page.replace_html 'contacts_container', :partial => @contact.group.contacts.sort!{|f,g| f.name <=> g.name}
            else
              page.replace_html 'contacts_list', :partial => 'contacts/contact', :object => @contacts
            end
            page.replace 'edit_container', '<div id="edit_container"></div>'
          else
            page.alert("Contact can not be saved")
          end
        end
      end
    end
  end
  
  def update
    respond_to do |format|
      format.js do
        render :update do |page|
          if @contact.update_attributes(params[:contact])
            page.alert("Contact can not be saved")
          end
        end
      end
    end
  end
  
  def destroy
    @contact.destroy
    respond_to do |format|
      format.js do
        render :update do |page|
          page.alert("deleted")
        end
      end
    end
  end
  
  def show_all_contacts
    @contacts = Contact.all
    unless @contacts.empty?
      @contacts.sort!{|f,g| f.name <=> g.name}
      respond_to do |format|
        format.js do
          render :update do |page|
            page.replace_html 'contacts_container', :partial => @contacts
            page.replace 'edit_container', '<div id="edit_container"></div>'
          end
        end
      end
    end
  end
  
  def display_edit
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace_html 'edit_container', :partial => '/contacts/form', :object => @contact
        end
      end
    end
  end
  
  def display_contact
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace_html 'edit_container', :partial => '/contacts/simple_contact', :object => @contact
        end
      end
    end
  end
  
  def display_new
    @contact = Contact.new
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace_html 'edit_container', :partial => '/contacts/form', :object => @contact
        end
      end
    end
  end
  
  def find_contact
    @contact = Contact.find(params[:id])
  end
  def find_groups
    @groups = Group.all
  end
end
