# coding: utf-8

module Api
  module V1
    class ContactsController < ApplicationController
      before_action :require_id_param, only: [:update, :destroy]

      def hello
        render json: { status: 'SUCCESS', message: 'Hello World',
                       data: 'hello world' }, status: :ok
      end

      def create
        contact = Contact.create(contact_params)
        if contact && contact.valid?
          render json: { status: 'SUCCESS', message: 'Contact created',
                         data: contact, token: contact.id }, status: :created
        else
          render json: { status: 'FAIL', message: 'Contact NOT created',
                         data: contact.errors }, status: :unprocessable_entity
        end
      end

      def find_by_token
        contact = Contact.find_by id: token_params

        if contact
          render json: { status: 'SUCCESS', message: 'Contact found',
                         data: contact }, status: :ok
        else
          render json: { status: 'FAIL',
                         message: 'No contact was found ' \
                         'with the provided token',
                         data: '' }, status: :unprocessable_entity
        end
      end

      def update
        contact = Contact.find(params[:id]) 

        if contact.update(contact_params)
          render json: { status: 'SUCCESS', message: 'Contact updated',
                         data: contact }, status: :ok
        else
          render json: { status: 'FAIL', message: 'Contact NOT Updated',
                         data: contact.erros }, status: :unprocessable_entity
        end
      end

      def destroy
        contact = Contact.find(params[:id])

        if contact.destroy
          render json: { status: 'SUCCESS', message: 'Contact destroyed',
                         data: [] }, status: :ok
        else
          render json: { status: 'FAIL', message: 'Contact NOT destroyed',
                         data: contact.erros }, status: :unprocessable_entity
        end
      end

      private

      def contact_params
        params.require(:contact).permit(:firstname, :lastname, :email)
      end

      def token_params
        params.require(:token_id)
      end

      def require_id_param
        if params[:id].nil?
          render json: { status: 'FAIL',
                         message: 'No contact was found ',
                         data: '' }, status: :unprocessable_entity
        end
      end
    end
  end
end
