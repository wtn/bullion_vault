module BullionVault
  class Error < StandardError; end

  class BullionVault::InvalidCookie < Error; end

  # 400
  class BadRequest < Error; end

  # 401
  class Unauthorized < Error; end

  # 403
  class Forbidden < Error; end

  # 404
  class NotFound < Error; end

  # 406
  class NotAcceptable < Error; end

  # 500
  class InternalServerError < Error; end

  # 502
  class BadGateway < Error; end

  # 503
  class ServiceUnavailable < Error; end
end
