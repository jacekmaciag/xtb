# frozen_string_literal: true

module Xtb
  class Error < StandardError; end

  class NotLoggedInError < Error; end
  class AlreadyLoggedInError < Error; end
end
