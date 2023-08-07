# frozen_string_literal: true

class EventsController < ApplicationController
  # TODO: implement the event saving endpoint

  def save
    event = Event.new(permit_params)
    render status: event.save ? 200 : 400
  rescue => e
    render status: 400
  end

  private

  def permit_params
    data = params.permit(:employee_id, :timestamp, :kind)
    data[:timestamp] = Time.at(data[:timestamp].to_i) rescue nil
    data
  end
end
