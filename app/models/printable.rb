require 'prawn'
require 'prawn/measurement_extensions'

module Printable
  class Base

    def render

      @pdf = Prawn::Document.new
      yield
      @pdf.render
    end

  end
end