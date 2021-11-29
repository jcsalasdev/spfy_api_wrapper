module Exceptions
    class ExceptionError < RuntimeError; end
  
    class BadRequestError < ExceptionError; end
    class UnauthorizedError < ExceptionError; end
    class ForbiddenError < ExceptionError; end
    class ApiRequestsQuotaReachedError < ExceptionError; end
    class NotFoundError < ExceptionError; end
    class UnprocessableEntityError < ExceptionError; end
    class ApiError < ExceptionError; end
  end