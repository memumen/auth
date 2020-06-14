# frozen_string_literal: true

# RouteHelpers
module RouteHelpers
  def app
    described_class
  end

  def response_body
    JSON(last_response.body)
  end
end
