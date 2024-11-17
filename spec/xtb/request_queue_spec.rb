# frozen_string_literal: true

require 'active_support'
require 'active_support/testing/time_helpers'

Time.zone = 'UTC'

RSpec.describe Xtb::RequestQueue do
  include ActiveSupport::Testing::TimeHelpers

  subject(:class_using_request_queue) do
    Class.new do
      include Xtb::RequestQueue

      class << self
        def method_using_request_queue
          with_request_queue do
            request_times << Time.zone.now
            'response'
          end
        end

        def request_times
          @request_times ||= []
        end
      end
    end
  end

  describe '.with_request_queue' do
    let(:min_request_interval) { 1 }

    before do
      allow(Xtb::Config).to receive(:min_request_interval).and_return(min_request_interval)
    end

    context 'when requests are coming from the same thread' do
      before do
        class_using_request_queue.method_using_request_queue
        class_using_request_queue.method_using_request_queue
      end

      specify 'it executes requests synchronously respecting the minimum request interval' do
        expect(class_using_request_queue.request_times.size).to eq(2)
        class_using_request_queue.request_times.each_cons(2) do
          expect do |earlier_time, later_time|
            expect(later_time - earlier_time).to be >= min_request_interval
          end
        end
      end
    end

    context 'when requests are coming from separate threads' do
      specify 'it executes requests synchronously respecting the minimum request interval' do
        threads = 2.times.map do |_i|
          Thread.new do
            Time.zone = 'UTC'
            class_using_request_queue.method_using_request_queue
          end
        end

        threads.each(&:join)

        expect(class_using_request_queue.request_times.size).to eq(2)
        class_using_request_queue.request_times.each_cons(2) do
          expect do |earlier_time, later_time|
            expect(later_time - earlier_time).to be >= min_request_interval
          end
        end
      end
    end
  end
end
