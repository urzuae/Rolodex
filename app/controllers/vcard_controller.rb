class VcardController < ApplicationController
  require 'vpim/vcard'
  
  def get_contact
    @contact = Contact.find(params[:id])
    @card = Vpim::Vcard::Maker.make2 do |maker|
      maker.add_name do |name|
        name.given = @contact.name
      end
      
    end
    send_data @card.to_s,
    :filename => "contact.vcf"
    
  end
end
