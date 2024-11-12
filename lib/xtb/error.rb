# frozen_string_literal: true

module Xtb
  # http://developers.xstore.pro/documentation/#error-messages
  class Error < StandardError; end

  class InvalidPriceError < Error; end

  class InvalidStopLossOrTakeProfitError < Error; end

  class InvalidVolumeError < Error; end

  class LoginDisabledError < Error; end

  class InvalidLoginOrPasswordError < Error; end

  class MarketClosedError < Error; end

  class MismatchedParametersError < Error; end

  class ModificationDeniedError < Error; end

  class NotEnoughMoneyError < Error; end

  class OffQuotesError < Error; end

  class OppositePositionsProhibitedError < Error; end

  class ShortPositionsProhibitedError < Error; end

  class PriceChangedError < Error; end

  class RequestTooFrequentError < Error; end

  class TooManyTradeRequestsError < Error; end

  class TradingOnInstrumentDisabledError < Error; end

  class TradingTimeoutError < Error; end

  class OtherError < Error; end

  class SymbolDoesNotExistForAccountError < Error; end

  class AccountCannotTradeOnSymbolError < Error; end

  class PendingOrderCannotBeClosedError < Error; end

  class CannotCloseOrderError < Error; end

  class NoSuchTransactionError < Error; end

  class UnknownInstrumentSymbolError < Error; end

  class UnknownTransactionTypeError < Error; end

  class NotLoggedInError < Error; end

  class MethodDoesNotExistError < Error; end

  class IncorrectPeriodError < Error; end

  class MissingDataError < Error; end

  class IncorrectCommandFormatError < Error; end

  class SymbolDoesNotExistError < Error; end

  class InvalidTokenError < Error; end

  class AlreadyLoggedInError < Error; end

  class SessionTimedOutError < Error; end

  class InvalidParametersError < Error; end

  class InternalError < Error; end

  class NoAccessError < Error; end

  class ConnectionLimitError < Error; end

  class DataLimitExceededError < Error; end

  class BlacklistedError < Error; end

  class CommandNotAllowedError < Error; end
end
