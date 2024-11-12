# frozen_string_literal: true

module Xtb
  # Factory for creating error objects based on error codes.
  class ErrorFactory
    ERROR_CODES = {
      'BE001': { klass: 'InvalidPriceError', description: 'Invalid price' },
      'BE002': { klass: 'InvalidStopLossOrTakeProfitError', description: 'Invalid StopLoss or TakeProfit' },
      'BE003': { klass: 'InvalidVolumeError', description: 'Invalid volume' },
      'BE004': { klass: 'LoginDisabledError', description: 'Login disabled' },
      'BE005': { klass: 'InvalidLoginOrPasswordError', description: 'Invalid login or password' },
      'BE006': { klass: 'MarketClosedError', description: 'Market for instrument is closed' },
      'BE007': { klass: 'MismatchedParametersError', description: 'Mismatched parameters' },
      'BE008': { klass: 'ModificationDeniedError', description: 'Modification is denied' },
      'BE009': { klass: 'NotEnoughMoneyError', description: 'Not enough money on account to perform trade' },
      'BE010': { klass: 'OffQuotesError', description: 'Off quotes' },
      'BE011': { klass: 'OppositePositionsProhibitedError', description: 'Opposite positions prohibited' },
      'BE012': { klass: 'ShortPositionsProhibitedError', description: 'Short positions prohibited' },
      'BE013': { klass: 'PriceChangedError', description: 'Price has changed' },
      'BE014': { klass: 'RequestTooFrequentError', description: 'Request too frequent' },
      'BE016': { klass: 'TooManyTradeRequestsError', description: 'Too many trade requests' },
      'BE018': { klass: 'TradingOnInstrumentDisabledError', description: 'Trading on instrument disabled' },
      'BE019': { klass: 'TradingTimeoutError', description: 'Trading timeout' },
      'BE020': { klass: 'OtherError', description: 'Other error' },
      'BE094': { klass: 'SymbolDoesNotExistForAccountError', description: 'Symbol does not exist for given account' },
      'BE095': { klass: 'AccountCannotTradeOnSymbolError', description: 'Account cannot trade on given symbol' },
      'BE096': { klass: 'PendingOrderCannotBeClosedError',
                 description: 'Pending order cannot be closed. Pending order must be deleted' },
      'BE097': { klass: 'CannotCloseOrderError', description: 'Cannot close already closed order' },
      'BE098': { klass: 'NoSuchTransactionError', description: 'No such transaction' },
      'BE101': { klass: 'UnknownInstrumentSymbolError', description: 'Unknown instrument symbol' },
      'BE102': { klass: 'UnknownTransactionTypeError', description: 'Unknown transaction type' },
      'BE103': { klass: 'NotLoggedInError', description: 'User is not logged' },
      'BE104': { klass: 'MethodDoesNotExistError', description: 'Method does not exist' },
      'BE105': { klass: 'IncorrectPeriodError', description: 'Incorrect period given' },
      'BE106': { klass: 'MissingDataError', description: 'Missing data' },
      'BE110': { klass: 'IncorrectCommandFormatError', description: 'Incorrect command format' },
      'BE115': { klass: 'SymbolDoesNotExistError', description: 'Symbol does not exist' },
      'BE116': { klass: 'SymbolDoesNotExistError', description: 'Symbol does not exist' },
      'BE117': { klass: 'InvalidTokenError', description: 'Invalid token' },
      'BE118': { klass: 'AlreadyLoggedInError', description: 'User already logged' },
      'BE200': { klass: 'SessionTimedOutError', description: 'Session timed out' },
      'EX000': { klass: 'InvalidParametersError', description: 'Invalid parameters' },
      'EX001': { klass: 'InternalError', description: 'Internal error, in case of such error, please contact support' },
      'EX003': { klass: 'InternalError', description: 'Internal error, request timed out' },
      'EX004': { klass: 'InvalidVolumeError',
                 description: 'Login credentials are incorrect or this login is not allowed to use an application \
                  with this appId' },
      'EX005': { klass: 'InvalidVolumeError', description: 'Internal error' },
      'EX006': { klass: 'NoAccessError', description: 'No access' },
      'EX007': { klass: 'InvalidVolumeError',
                 description: 'Invalid login or password. This login/password is disabled for 10 minutes' },
      'EX008': { klass: 'ConnectionLimitError', description: 'You have reached the connection limit' },
      'EX009': { klass: 'DataLimitExceededError', description: 'Data limit potentially exceeded' },
      'EX010': { klass: 'BlacklistedError', description: 'Your login is on the black list' },
      'EX011': { klass: 'CommandNotAllowedError', description: 'You are not allowed to execute this command' }
    }.freeze

    ERROR_CODE_DUPLICATES = {
      'BE016': ['BE017'],
      'BE020': ('BE021'..'BE037').to_a + ['BE099'],
      'BE115': ['BE116'],
      'EX001': %w[BE000 EX002]
    }.freeze

    # Create an error object based on the error code. The API specifies multiple error codes can be
    # matched to the same error, so a list of duplicates is provided, plus a mapping for codes
    # matching 'SExxx' to 'EX001'.
    # @param error_code [String]
    # @param error_description [String] (optional)
    # @return [Xtb::Error]
    def self.create(error_code, error_description = '')
      error_code = error_code.to_sym
      mapped_code = ERROR_CODES.keys.include?(error_code) ? error_code : error_code_for_duplicate(error_code)
      error = ERROR_CODES.fetch(mapped_code, nil)
      return default_error(error_code, error_description) if error.nil?

      error_description = error_description.empty? ? error[:description] : error_description
      message = "(#{error_code}) #{error_description}"
      Xtb.const_get(error[:klass]).new(message)
    end

    def self.default_error(error_code, error_description)
      Xtb::Error.new("(#{error_code}) #{error_description}")
    end

    def self.error_code_for_duplicate(error_code_duplicate)
      code = nil

      if error_code_duplicate.start_with?('SE')
        code = :EX001
      else
        ERROR_CODE_DUPLICATES.each do |error_code, duplicates|
          code = error_code if duplicates.include?(error_code_duplicate)
        end
      end

      code
    end
  end
end
