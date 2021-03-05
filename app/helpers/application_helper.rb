# frozen_string_literal: true

# Defines Helper Methods available to the ApplicationController
module ApplicationHelper
  def render_if(condition, record)
    render record if condition
  end
end
