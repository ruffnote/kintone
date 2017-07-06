class Kintone::KintoneError < StandardError
  attr_reader :message_text, :id, :code, :http_status, :errors

  def initialize(messages, http_status)
    @message_text = messages['message']
    @id = messages['id']
    @code = messages['code']
    @errors = messages['errors']
    @http_status = http_status
    message_body = format('%s [%s] %s(%s)', @http_status, @code, @message_text, @id)
    message_body = format("%s\n%s", message_body, JSON.pretty_generate(@errors)) if @errors.present?
    super(message_body)
  end
end