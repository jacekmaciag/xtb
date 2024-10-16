# frozen_string_literal: true

RSpec.describe Xtb::Http::AllSymbols do
  subject(:command) { described_class.new }

  let(:response) do
    JSON.dump({
                'status' => true,
                'return_data' =>
                  [
                    {
                      'ask' => 4000.0,
                      'bid' => 4000.0,
                      'categoryName' => 'Forex',
                      'contractSize' => 100_000,
                      'currency' => 'USD',
                      'currencyPair' => true,
                      'currencyProfit' => 'PLN',
                      'description' => 'USD/PLN',
                      'exemode' => 0,
                      'expiration' => nil,
                      'groupName' => 'Minor',
                      'high' => 4000.0,
                      'initialMargin' => 0,
                      'instantMaxVolume' => 0,
                      'leverage' => 1.5,
                      'longOnly' => false,
                      'lotMax' => 10.0,
                      'lotMin' => 0.1,
                      'lotStep' => 0.1,
                      'low' => 3500.0,
                      'marginHedged' => 0,
                      'marginHedgedStrong' => false,
                      'marginMaintenance' => nil,
                      'marginMode' => 101,
                      'pipsPrecision' => 2,
                      'percentage' => 100.0,
                      'precision' => 2,
                      'profitMode' => 5,
                      'quoteId' => 1,
                      'quoteIdCross' => 1,
                      'shortSelling' => true,
                      'spreadRaw' => 0.000003,
                      'spreadTable' => 0.00042,
                      'starting' => nil,
                      'stepRuleId' => 1,
                      'stopsLevel' => 0,
                      'swap_rollover3days' => 0,
                      'swapEnable' => true,
                      'swapLong' => -2.55929,
                      'swapShort' => 0.131,
                      'swapType' => 0,
                      'symbol' => 'USDPLN',
                      'tickSize' => 1.0,
                      'tickValue' => 1.0,
                      'time' => 1_272_446_136_891,
                      'timeString' => 'Thu May 23 12:23:44 EDT 2013',
                      'trailingEnabled' => true,
                      'type' => 21
                    },
                    {
                      'ask' => 4000.0,
                      'bid' => 4000.0,
                      'categoryName' => 'Forex',
                      'contractSize' => 100_000,
                      'currency' => 'USD',
                      'currencyPair' => true,
                      'currencyProfit' => 'SEK',
                      'description' => 'USD/SEK',
                      'exemode' => 0,
                      'expiration' => nil,
                      'groupName' => 'Minor',
                      'high' => 4000.0,
                      'initialMargin' => 0,
                      'instantMaxVolume' => 0,
                      'leverage' => 1.5,
                      'longOnly' => false,
                      'lotMax' => 10.0,
                      'lotMin' => 0.1,
                      'lotStep' => 0.1,
                      'low' => 3500.0,
                      'marginHedged' => 0,
                      'marginHedgedStrong' => false,
                      'marginMaintenance' => nil,
                      'marginMode' => 101,
                      'pipsPrecision' => 2,
                      'percentage' => 100.0,
                      'precision' => 2,
                      'profitMode' => 5,
                      'quoteId' => 1,
                      'quoteIdCross' => 1,
                      'shortSelling' => true,
                      'spreadRaw' => 0.000003,
                      'spreadTable' => 0.00042,
                      'starting' => nil,
                      'stepRuleId' => 1,
                      'stopsLevel' => 0,
                      'swap_rollover3days' => 0,
                      'swapEnable' => true,
                      'swapLong' => -2.55929,
                      'swapShort' => 0.131,
                      'swapType' => 0,
                      'symbol' => 'USDPLN',
                      'tickSize' => 1.0,
                      'tickValue' => 1.0,
                      'time' => 1_272_446_136_891,
                      'timeString' => 'Thu May 23 12:23:44 EDT 2013',
                      'trailingEnabled' => true,
                      'type' => 21
                    }
                  ]
              })
  end

  describe '#call' do
    before do
      allow(Xtb::Http::SslClient).to receive(:request).and_return(response)
    end

    specify do
      expect(command.call)
        .to each(have_attributes(

                   ask: 4000.0,
                   bid: 4000.0,
                   category_name: 'Forex'
                 ))
    end
  end
end
