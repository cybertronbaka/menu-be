# frozen_string_literal: true

module Api
  module V1
    class PicturesController < ApplicationController
      before_action :authenticate_user!, only: :create

      def create
        render json: { url: create_picture.url }, status: :ok
      end

      private

      def create_picture
        Picture.create!(image: picture_params[:image])
      end

      def picture_params
        params.require(:picture).permit(
            :image
        )
      end
    end
  end
end