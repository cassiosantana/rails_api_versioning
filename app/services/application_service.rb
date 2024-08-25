# frozen_string_literal: true

class ApplicationService
  def initialize(...); end

  def self.call(...)
    new(...).call
  end

  def self.call!(...)
    new(...).call!
  end
end
