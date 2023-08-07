# frozen_string_literal: true

class ReportGenerator
  # TODO: - fetch range of events and generate Report

  def prepare_report(employee_id, from_date, to_date)
    events = fetch_events(employee_id, from_date, to_date)
    worktime_hrs = 0.00
    problematic_dates = []
    
    events.group_by{ |record| record.timestamp.to_date.to_s }.each do |date, day_events|
      if day_events.count == 2
        in_event = day_events.select { |event| event.kind == 'in' }.first
        out_event = day_events.select { |event| event.kind == 'out' }.first
        worktime_hrs += ((out_event.timestamp - in_event.timestamp) / 1.hour)
      else
        problematic_dates << date
      end
    end
    { "employee_id": employee_id.to_i, "from": from_date, "to": to_date, 
      "worktime_hrs": worktime_hrs.round(2),"problematic_dates": problematic_dates }
  end

  def fetch_events(employee_id, from_date, to_date)
    Event.where(employee_id: employee_id).where(
      timestamp: from_date.to_datetime.beginning_of_day..to_date.to_datetime.end_of_day
    )
  end
end
