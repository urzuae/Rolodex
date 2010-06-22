class ContactsController < ApplicationController
  before_filter :find_contact, :only => [:update, :destroy]
  def create
    @contact = Contact.new(params[:contact])
    respond_to do |format|
      format.js do
        if @contact.save
          render :update do |page|
            page.insert_html :bottom, 'contacts_list', :partial => @contact
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
          end
        end
      end
    end
  end
  
  def find_contact
    @contact = Contact.find(params[:id])
  end
end
