# frozen_string_literal: true
 
module Api
  module V1
    class EventsController < ApplicationController
      before_action :set_event, only: %i[show update delete]
      skip_before_action :verify_authenticity_token

      def index
        events = Event.all
        if events.present?
          render json: events, status: :ok
        else
          render json: {
            message: 'data not found'
          }, status: :unprocessable_entity
        end
      end

      def show
        @event = set_event
        render json: { event: @event }, status: :ok
      end

      def showrule
        @event = set_event
        @rules = @event.rules
        render json: {eventRule: @rules }, status: :ok
      end

      def create
        @event = Event.create(event_param)
        if @event.save
          render json: { result: true, msg: 'Success' }, status: :created
        else
          render json: { result: false, events: @event.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @event.update(event_param)
          render json: { result: true, msg: 'update success' }
        else
          render json: { result: false, msg: 'update failed' }
        end
      end

      def delete
        if @event.destroy
          render json: { result: true, msg: 'delete success' }
        else
          render json: { result: false, msg: 'delete failed' }
        end
      end

      private

      def event_param
        params.permit(:title, :desc, :image)
      end

      def set_event
        @event = Event.find_by(id: params[:id])
      end
    end
  end
end
