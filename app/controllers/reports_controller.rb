# frozen_string_literal: true

class ReportsController < ApplicationController
  # TODO: implement report generation endpoint - it should delegate to ReportGenerator
  def get
    report = Report.get(params['employee_id'], params['from'], params['to'])
    render json: report
  end
end
