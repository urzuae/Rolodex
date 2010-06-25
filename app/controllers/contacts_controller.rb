class ContactsController < ApplicationController
  before_filter :find_contact, :only => [:update, :destroy, :display_edit, :display_contact]
  before_filter :find_groups, :only => [:display_edit, :display_new]
  
  def create
    @contact = Contact.new(params[:contact])
    respond_to do |format|
      format.js do
        render :update do |page|
          if @contact.save
            @contacts = Contact.all
            unless @contact.group_id == nil
              page.replace_html 'groups_container', :partial => 'groups/group', :collection => Group.all
              page.replace_html 'contacts_container', :partial => @contact.group.contacts.sort!{|f,g| f.name <=> g.name}
            else
              page.replace_html 'contacts_container', :partial => 'contacts/contact', :collection => @contacts
            end
            page.replace 'edit_container', '<div id="edit_container"></div>'
            page.replace_html 'contacts_length', "#{Contact.all.length}"
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
            page.replace 'edit_container', '<div id="edit_container"></div>'
            page.alert("Contact edited")
          else
            page.alert("Contact not edited")
          end
        end
      end
    end
  end
  
  def destroy_single_contact
    @contact = Contact.find(params[:id])
    unless @contact.group_id == nil
      @group = @contact.group
    end
    @contact.destroy
    @contacts = Contact.all
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace_html 'groups_container', :partial => 'groups/group', :collection => Group.all
          page.replace_html 'contacts_container', :partial => @contacts
          page.replace 'edit_container', '<div id="edit_container"></div>'
          page.replace_html 'contacts_length', "#{@contacts.length}"
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
  def show_filter
    results = ""
    @contacts = Contact.all
    respond_to do |format|
      format.js do
        @contacts.each do |f|
          if f.name != nil
            results += f.name + " "
          end
        end
        render :update do |page|
          page.replace_html "search_results", "#{results}"
        end
      end
    end
  end
  def contacts_name
    @contacts = Contact.all
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace_html 'search_results', :partial => '/contacts/contacts_name', :collection => @contacts
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
