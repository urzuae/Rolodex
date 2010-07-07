class ContactsController < ApplicationController
  before_filter :find_list
  before_filter :find_contact, :only => [:update, :destroy, :display_edit, :display_contact, :destroy_single_contact]
  before_filter :find_all_contacts, :only => [:show_all_contacts, :contacts_name]
  before_filter :find_groups, :only => [:display_edit, :display_new]
  
  require 'csv'
  
  def create
    @contact = @list.contacts.build(params[:contact])
    respond_to do |format|
      format.js do
        render :update do |page|
          if @contact.save
            @contacts = @list.contacts
            unless @contact.group_id == nil
              page.replace_html 'groups_container', :partial => 'groups/group', :collection => @list.groups
              page.replace_html 'contacts_container', :partial => @contact.group.contacts.sort!{|f,g| f.name <=> g.name}
            else
              page.replace_html 'contacts_container', :partial => 'contacts/contact', :collection => @contacts
            end
            page.replace 'edit_container', '<div id="edit_container"></div>'
            page.replace_html 'contacts_length', "#{@list.contacts.length}"
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
    unless @contact.group_id == nil
      @group = @contact.group
    end
    @contact.destroy
    @contacts = @list.contacts
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace_html 'groups_container', :partial => 'groups/group', :collection => @list.groups
          page.replace_html 'contacts_container', :partial => @contacts
          page.replace 'edit_container', '<div id="edit_container"></div>'
          page.replace_html 'contacts_length', "#{@contacts.length}"
        end
      end
    end
  end
  
  def show_all_contacts
    respond_to do |format|
      format.js do
        render :update do |page|
          unless @contacts.empty?
            @contacts.sort!{|f,g| f.name <=> g.name}
            page.replace_html 'contacts_container', :partial => @contacts
            page.replace 'edit_container', '<div id="edit_container"></div>'
          else
            page.alert('No contacts')
          end
        end
      end
    end
  end
  
  def display_edit
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace_html 'edit_container', :partial => '/contacts/form_edit', :object => @contact, :object => @contact_photo
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
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace_html 'search_results', :partial => '/contacts/contacts_name', :collection => @contacts
        end
      end
    end
  end
  
  def find_contact
    @contact = @list.contacts.find(params[:id])
  end
  def find_all_contacts
    @contacts = @list.contacts
  end
  def find_groups
    @groups = @list.groups
  end
  def export_contact
    @contacts = Contact.all
    report = StringIO.new
    CSV::Writer.generate(report, ',') do |title|
      title << ['Name','Address','Phone']
      @contacts.each do |f|
        title << [f.name,f.address,f.phone]
      end
    end
    report.rewind
    send_data(report.read, :type => 'text/csv;charset=iso-8859-1;header=present', :filename => 'report.csv', :disposition => 'attachment', :encoding => 'utf8')
  end
  def find_list
    @user = User.find_by_username(current_user.username)
    @list = List.find_by_id(@user.id)
  end
end
