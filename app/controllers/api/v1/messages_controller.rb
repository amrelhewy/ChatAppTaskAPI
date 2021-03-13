module Api
  module V1
    class MessagesController < ApplicationController
      before_action :set_message, only: [:update, :destroy]
      before_action :get_messages_by_chat, only: [:show]

      # GET /messages
      def index
        @messages = Message.all

        render json: @messages
      end

      # GET api/v1/chats/:token/:number/messages
      def show
        render json: @messages
      end

      #searching messages with elastic search

      def search
        unless params[:query].blank?
          chat = Chat.find_by(application_token: params[:token], number: params[:number].to_i)
          if chat
            @results = Message.search(params[:query], chat[:id])
            render json: @results, status: 200
          else
            render status: 404
          end
        else
          render status: 404
        end
      end

      # POST /messages
      def create
        chat_room = Chat.find_by(application_token: params[:application_token], number: params[:chat_number])

        unless chat_room.nil?
          MesageWorker.perform_async(chat_room[:id], params[:body])
          @message = Message.new(chat_id: chat_room[:id], body: params[:body])
          @message.add_message_number
          render json: @message, status: :created
        else
          render status: :unprocessable_entity
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_message
        @message = Message.find(params[:id])
      end

      def get_messages_by_chat
        chat = Chat.find_by(application_token: params[:token], number: params[:number])
        if chat
          @messages = Message.where(chat_id: chat[:id])
        else
          @messages = []
        end
      end

      # Only allow a trusted parameter "white list" through.
      def message_params
        params.require(:message).permit(:body)
      end
    end
  end
end
