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
        contact = Contact.find(params[:id])

        if contact.update(contact_params)
          render json: {status: 'SUCCESS', message: 'Contact updated',
                        data: contact}, status: :ok
        else
          render json: {status: 'FAIL', message: 'Contact NOT Updated',
                        data: contact.erros}, status: :unprocessable_entity
        end
      end

      def destroy
        contact = Contact.find(params[:id])

        if contact.destroy
          render json: {status: 'SUCCESS', message: 'Contact destroyed',
                        data: []}, status: :ok
        else
          render json: {status: 'FAIL', message: 'Contact NOT destroyed',
                        data: contact.erros}, status: :unprocessable_entity
        end
      end

      private
      def contact_params
        params.require(:contact).permit(:firstname, :lastname, :email)
      end
    end
  end
end
