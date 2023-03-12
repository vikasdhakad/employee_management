# frozen_string_literal: true

class ReportGenerator
  # TODO: - fetch range of events and generate Report

  def prepare_report(employee_id, from_date, to_date)
    events = fetch_events(employee_id, from_date, to_date)
    worktime_hrs = 0
    problematic_dates = []
    (from_date.to_datetime..to_date.to_datetime).to_a.each do |date|
      day_events = events.where(timestamp: from_date.to_datetime.beginning_of_day..from_date.to_datetime.end_of_day)
      
      if day_events.count == 2
        in_time = day_events.where(kind: 'in')
        out_time = day_events.where(kind: 'out')
        worktime_hrs += ((out_time - in_time) / 1.hour)
      elsif day_events.count == 1
        problematic_dates << date
      elsif day_events.count == 0
        worktime_hrs = 0
      end
    end
    { "employee_id": employee_id, "from": from_date, "to": to_date, 
      "worktime_hrs": worktime_hrs.round(2),"problematic_dates": problematic_dates }
  end

  def fetch_events(employee_id, from_date, to_date)
    Event.where(employee_id: employee_id).where(
      timestamp: from_date.to_datetime.beginning_of_day..to_date.to_datetime.end_of_day
    )
  end
end
