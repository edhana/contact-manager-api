module Api
  module V1
    class ContactsController < ApplicationController
      def create
        contact = Contact.create(contact_params)
        if contact
          render json: {status: 'SUCCESS', message: 'Contact created',
                        data: contact}, status: :ok
        else
          render json: {status: 'FAIL', message: 'Contact NOT created',
                        data: contact.errors}, status: :unprocessable_entity
        end
      end

      def update
      end

      def destroy
      end

      private
      def contact_params
        params.require(:contact).permit(:firstname, :lastname, :email)
      end
    end
  end
end
