module Api
  module V1
    class ChatsController < ApplicationController
      before_action :set_chats, only: [:show]

      # GET /chats
      def index
        @chats = Chat.all

        render json: @chats
      end

      # GET api/v1/applications/:token/chats
      def show
        render json: @chats
      end

      # POST /chats
      def create
        @application = Application.find(params[:application_token])
        if @application
          ChatWorker.perform_async(params[:application_token])
          @chat = Chat.new(chat_params)
          @chat.add_chat_number
          render json: @chat, status: :created
        else
          render status: 404
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_chats
        @chats = Chat.where(application_token: params[:token])
      end

      # Only allow a trusted parameter "white list" through.
      def chat_params
        params.require(:chat).permit(:application_token)
      end
    end
  end
end
