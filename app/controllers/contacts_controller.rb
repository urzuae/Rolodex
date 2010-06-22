class ContactsController < ApplicationController
  before_filter :find_contact, :only => [:update, :destroy, :display_edit, :display_contact]
  before_filter :find_groups, :only => [:display_edit, :display_new]
  
  def create
    @contact = Contact.new(params[:contact])
    respond_to do |format|
      format.js do
        render :update do |page|
          if @contact.save
            page.insert_html :bottom, 'contacts_list', :partial => @contact
          else
            page.alert("Contact can not be saved")
          end
        end
      end
    end
  end
  
  def update
  end
  
  def destroy
    @contact.destroy
  end
  
  def show_all_contacts
    @contacts = Contact.all
    unless @contacts.empty?
      @contacts.sort!{|f,g| f.name <=> g.name}
      respond_to do |format|
        format.js do
          render :update do |page|
            page.replace 'contacts_container', :partial => @contacts
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
