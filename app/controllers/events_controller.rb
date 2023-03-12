# frozen_string_literal: true

class EventsController < ApplicationController
  # TODO: implement the event saving endpoint

  def save
    event = Event.new(permit_params)
    render json: event.save ? 200 : 400
  end

  private

  def permit_params
    data = params.require(:event).permit(:employee_id, :timestamp, :kind)
    data[:timestamp] = DateTime.strptime(data[:timestamp],'%s')
    data
  end
end
