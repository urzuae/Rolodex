class ContactsController < ApplicationController
  before_filter :find_contact, :only => [:show, :update, :destroy]
  def create
    @contact = Contact.new(params[:contact])
    respond_to do |format|
      format.js do |page|
        if @contact.save
          render :update do |page|
            page.insert_html(:bottom, 'contacts_list', :partial => @contact)
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
  def find_contact
    @contact = Contact.find(params[:id])
  end
end
